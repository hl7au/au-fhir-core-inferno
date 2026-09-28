# frozen_string_literal: true

require 'json'
require 'open3'
require 'tmpdir'
require_relative '../../rakelib/ci_build'

RSpec.describe AUCoreTestKit::CIBuild do
  repo_root = File.expand_path('../..', __dir__)
  ci_build_suite_id = 'au_core_v300_ci_build'
  # Captured when the spec files load, before any example requires the suite itself.
  registered_at_boot = Inferno::Repositories::TestSuites.new.find(ci_build_suite_id).present?

  let(:config) { JSON.parse(File.read(File.join(repo_root, described_class::CONFIG_FILE))) }

  describe 'config.ci-build.json' do
    it 'tracks a ci-build version from the build.fhir.org package' do
      expect(config.dig('ig', 'version')).to end_with('-ci-build')
      expect(config.dig('ig', 'package_archive_path')).to eq('lib/au_core_test_kit/igs/ci-build.tgz')
      expect(config.dig('ci_build', 'package_url')).to eq('https://build.fhir.org/ig/hl7au/au-fhir-core/package.tgz')
      expect(config.dig('ci_build', 'package_date')).to match(/\A\d{14}\z/)
    end

    it 'does not override the validator IG with rewrite_igs' do
      expect(config['suite']).not_to have_key('rewrite_igs')
    end
  end

  describe 'the generated ci-build suite' do
    it 'is not registered unless INFERNO_CI_BUILD_SUITES=true' do
      skip 'INFERNO_CI_BUILD_SUITES=true in this environment' if ENV['INFERNO_CI_BUILD_SUITES'] == 'true'

      expect(registered_at_boot).to be(false)
    end

    context 'when INFERNO_CI_BUILD_SUITES=true' do
      # Boots Inferno in a child process with the flag set, as a deployment that opts in
      # would, and reports what it registered.
      boot_script = <<~RUBY
        require 'json'
        require 'inferno/config/application'
        require 'inferno/utils/migration'
        Inferno::Utils::Migration.new.run
        require 'inferno'
        Inferno::Application.finalize!
        suite = Inferno::Repositories::TestSuites.new.find('#{ci_build_suite_id}')
        puts JSON.generate(
          id: suite&.id,
          title: suite&.title,
          description: suite&.description,
          igs: suite&.fhir_validators&.values&.flatten&.flat_map(&:igs),
          snomed_editions: suite&.fhir_validators&.values&.flatten&.map { |v| v.validation_context.definition[:snomedCT] }
        )
      RUBY

      before(:context) do
        output, status = Open3.capture2e(
          { 'APP_ENV' => 'test', 'INFERNO_CI_BUILD_SUITES' => 'true' },
          RbConfig.ruby, '-e', boot_script, chdir: repo_root
        )
        raise "Booting Inferno with INFERNO_CI_BUILD_SUITES=true failed:\n#{output}" unless status.success?

        @suite = JSON.parse(output.lines.last)
      end

      it 'registers the suite with an id derived from the recorded CI build version' do
        version = config.dig('ig', 'version')
        expect(@suite['id']).to eq("au_core_v#{version.delete('.').tr('-', '_')}")
      end

      it 'validates against the CI build package id, never a file path' do
        expect(@suite['igs'].uniq).to eq(['hl7.fhir.au.core#current'])
      end

      it 'pins the Australian SNOMED CT edition' do
        expect(@suite['snomed_editions'].uniq).to eq(['au'])
      end

      it 'says it tracks the CI build and that sessions may stop rendering' do
        expect(@suite['title']).to include('ci-build').and include('tracks the CI build')
        expect(@suite['description']).to include('tracks the AU Core CI build').and include('stop rendering')
      end
    end
  end

  describe '#annotate_suite' do
    subject(:ci_build) { described_class.new(root: repo_root) }

    let(:version) { config.dig('ig', 'version') }
    let(:generated) do
      <<~RUBY
        title 'AU Core v#{version}'
        description %(
                The AU Core Test Kit tests systems.
        )
        igs 'hl7.fhir.au.core##{version}'
      RUBY
    end

    it 'points the validator at #current and labels the suite as tracking the CI build' do
      annotated = ci_build.annotate_suite(generated)

      expect(annotated).to include("igs 'hl7.fhir.au.core#current'")
      expect(annotated).to include("title 'AU Core v#{version} (tracks the CI build)'")
      expect(annotated).to include('stop rendering')
      expect(annotated).not_to include("hl7.fhir.au.core##{version}")
    end

    it 'fails loudly when the generator output no longer matches' do
      expect { ci_build.annotate_suite(generated.sub(/igs .*$/, '')) }
        .to raise_error(described_class::Error, /igs 'hl7.fhir.au.core#/)
    end
  end

  describe 'download and change detection' do
    subject(:ci_build) { described_class.new(root: tmp_root) }

    let(:tmp_root) { Dir.mktmpdir }
    let(:manifest_url) { config.dig('ci_build', 'manifest_url') }
    let(:package_url) { config.dig('ci_build', 'package_url') }

    def package_tgz(package_json)
      tar = StringIO.new
      Gem::Package::TarWriter.new(tar) do |writer|
        body = JSON.generate(package_json)
        writer.add_file_simple('package/package.json', 0o644, body.bytesize) { |io| io.write(body) }
      end
      gz = StringIO.new
      Zlib::GzipWriter.wrap(gz) { |writer| writer.write(tar.string) }
      gz.string
    end

    before do
      File.write(File.join(tmp_root, described_class::CONFIG_FILE), JSON.pretty_generate(config))
    end

    after { FileUtils.remove_entry(tmp_root) }

    it 'reports a change only when the manifest date differs from the recorded one' do
      stub_request(:get, manifest_url)
        .to_return(body: { version: '3.0.0-ci-build', date: config.dig('ci_build', 'package_date') }.to_json)
      expect(ci_build.changed?).to be(false)

      stub_request(:get, manifest_url).to_return(body: { version: '3.0.0-ci-build', date: '20991231000000' }.to_json)
      expect(ci_build.changed?).to be(true)
    end

    it 'saves the package and records its version and date from the package itself' do
      stub_request(:get, package_url)
        .to_return(body: package_tgz(name: 'hl7.fhir.au.core', version: '3.1.0-ci-build', date: '20991231000000'))

      ci_build.download

      expect(File).to exist(File.join(tmp_root, 'lib/au_core_test_kit/igs/ci-build.tgz'))
      expect(ci_build.version).to eq('3.1.0-ci-build')
      expect(ci_build.recorded_date).to eq('20991231000000')
    end

    it 'refuses a package whose version is not a ci-build' do
      stub_request(:get, package_url)
        .to_return(body: package_tgz(name: 'hl7.fhir.au.core', version: '3.0.0', date: '20991231000000'))

      expect { ci_build.download }.to raise_error(described_class::Error, /ci-build/)
    end
  end
end
