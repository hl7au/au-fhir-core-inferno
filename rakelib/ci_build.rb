# frozen_string_literal: true

require 'fileutils'
require 'json'
require 'net/http'
require 'rubygems/package'
require 'stringio'
require 'zlib'

module AUCoreTestKit
  # Keeps the ci-build suite in step with the AU Core CI build published on build.fhir.org.
  #
  # The generator names its output directory, runnable ids, module, suite title and
  # validator IG after `ig.version`, which suits released versions. The ci-build suite
  # instead needs a stable directory (so lib/au_core_test_kit.rb can require it behind
  # INFERNO_CI_BUILD_SUITES), stable runnable ids (so sessions and the aggregator's kit page
  # entry survive a CI version bump), a validator IG of hl7.fhir.au.core#current (which the
  # validator refreshes from build.fhir.org) and a title and description that say it tracks
  # the CI build. The title and profile versions keep the IG package version, so the suite
  # never claims a version ahead of the IG. This class generates into the versioned
  # directory as usual, then moves, renames and annotates it.
  class CIBuild
    CONFIG_FILE = 'config.ci-build.json'
    BASIC_CONFIG_FILE = 'config.basic.json'
    KIT_ENTRY_FILE = 'lib/au_core_test_kit.rb'
    GENERATED_DIR = 'lib/au_core_test_kit/generated'
    OUTPUT_DIR = "#{GENERATED_DIR}/ci-build".freeze
    SUITE_FILE = 'au_core_test_suite.rb'
    IG_PACKAGE_ID = 'hl7.fhir.au.core'
    VALIDATOR_IG = "#{IG_PACKAGE_ID}#current".freeze
    SUITE_ID = 'au_core_ci_build'
    MODULE_NAME = 'AUCoreCIBuild'
    CI_BUILD_VERSION_SUFFIX = '-ci-build'
    MAX_REDIRECTS = 3

    class Error < StandardError; end

    attr_reader :root

    # Hands values to later steps of a GitHub Actions job; a no-op outside Actions.
    def self.write_github_output(values)
      return unless ENV['GITHUB_OUTPUT']

      File.open(ENV.fetch('GITHUB_OUTPUT'), 'a') do |file|
        values.each { |key, value| file.puts("#{key}=#{value}") }
      end
    end

    def initialize(root: Dir.pwd)
      @root = root
    end

    def config
      JSON.parse(File.read(path(CONFIG_FILE)))
    end

    def version
      config.dig('ig', 'version')
    end

    def recorded_date
      config.dig('ci_build', 'package_date')
    end

    def package_path
      path(config.dig('ig', 'package_archive_path'))
    end

    def published_manifest
      JSON.parse(http_get(config.dig('ci_build', 'manifest_url')))
    end

    def changed?
      published_manifest['date'] != recorded_date
    end

    # Downloads the CI build package and records its version and date in the ci-build
    # config. Both come from the package itself rather than the manifest, so a CI build
    # published between the two requests cannot leave them out of step. Nothing is written
    # unless the package is a ci-build version.
    def download
      body = http_get(config.dig('ci_build', 'package_url'))
      package = package_json(body)
      ensure_ci_build_version!(package.fetch('version'))
      FileUtils.mkdir_p(File.dirname(package_path))
      File.binwrite(package_path, body)
      record(package)
    end

    # Downloads when the CI build changed (or when forced) and regenerates the suite. If any
    # step fails, config.ci-build.json is put back so the next refresh tries again rather
    # than reporting the CI build as unchanged.
    def refresh(force: false)
      return false unless force || changed?

      original_config = File.read(path(CONFIG_FILE))
      begin
        download
        yield
      rescue StandardError
        File.write(path(CONFIG_FILE), original_config)
        raise
      end
      true
    end

    def generate
      ensure_package!
      ensure_ci_build_version!(version)

      versioned_dir = path(GENERATED_DIR, "v#{version}")
      run_generator(versioned_dir)
      FileUtils.rm_rf(path(OUTPUT_DIR))
      FileUtils.mv(versioned_dir, path(OUTPUT_DIR))
      fix_runnable_ids(path(OUTPUT_DIR))
      suite_path = path(OUTPUT_DIR, SUITE_FILE)
      File.write(suite_path, annotate_suite(File.read(suite_path)))
    end

    # Replaces the version-derived id prefix (e.g. au_core_v300_ci_build) and module name
    # (e.g. AUCoreV300_CI_BUILD) in every generated file with the fixed ones.
    def fix_runnable_ids(dir)
      renames = versioned_names.zip([SUITE_ID, MODULE_NAME])
      ensure_versioned_names!(File.read(File.join(dir, SUITE_FILE)))

      Dir.glob(File.join(dir, '**', '*.{rb,yml}')).each do |file|
        source = File.read(file)
        renamed = renames.reduce(source) { |text, (from, to)| text.gsub(from, to) }
        File.write(file, renamed) unless renamed == source
      end
    end

    def annotate_suite(source)
      generated_ig = "igs '#{IG_PACKAGE_ID}##{version}'"
      generated_title = "title 'AU Core v#{version}'"
      [generated_ig, generated_title, "description %(\n"].each do |expected|
        next if source.scan(expected).one?

        raise Error, "Expected exactly one `#{expected.strip}` in the generated ci-build suite; " \
                     'the generator output has changed, so update AUCoreTestKit::CIBuild#annotate_suite.'
      end

      source
        .sub(generated_ig, "igs '#{VALIDATOR_IG}'")
        .sub(generated_title, "title 'AU Core v#{version} (tracks the CI build)'")
        .sub("description %(\n", "description %(\n#{ci_build_notice}\n")
    end

    def ci_build_notice
      <<~NOTICE.gsub(/^/, '        ')
        **This suite tracks the AU Core CI build** at
        [build.fhir.org/ig/hl7au/au-fhir-core](https://build.fhir.org/ig/hl7au/au-fhir-core/index.html),
        not a released version of AU Core. It is regenerated automatically when the CI build
        changes, and a regeneration can rename or remove tests, so a session started before a
        regeneration may stop rendering; start a new session if that happens. Resources are
        validated against `#{VALIDATOR_IG}`, which the validator refreshes from build.fhir.org.
      NOTICE
    end

    private

    def path(*parts)
      File.join(root, *parts)
    end

    def run_generator(versioned_dir)
      require 'inferno_suite_generator'
      kit_entry = File.read(path(KIT_ENTRY_FILE))
      FileUtils.rm_rf(versioned_dir)
      Dir.chdir(root) do
        InfernoSuiteGenerator::Generator.generate([BASIC_CONFIG_FILE, CONFIG_FILE])
      end
      # The generator appends an unconditional require for the suite it wrote; the ci-build
      # suite is required behind INFERNO_CI_BUILD_SUITES instead.
      File.write(path(KIT_ENTRY_FILE), kit_entry)
    end

    def versioned_names
      reformatted = "v#{version}".delete('.').tr('-', '_')
      ["au_core_#{reformatted}", "AUCore#{reformatted.upcase}"]
    end

    def ensure_versioned_names!(suite_source)
      versioned_id, versioned_module = versioned_names
      return if suite_source.scan("id :#{versioned_id}\n").one? && suite_source.include?("module #{versioned_module}\n")

      raise Error, "Expected `id :#{versioned_id}` and `module #{versioned_module}` in the generated ci-build suite; " \
                   'the generator output has changed, so update AUCoreTestKit::CIBuild#fix_runnable_ids.'
    end

    # Also guards the rm_rf of generated/v<version> against ever removing a released suite.
    def ensure_ci_build_version!(candidate)
      return if candidate.to_s.end_with?(CI_BUILD_VERSION_SUFFIX)

      raise Error, "CI build version is #{candidate.inspect}; expected a version ending in #{CI_BUILD_VERSION_SUFFIX}."
    end

    # Downloads the package when it is missing. One downloaded earlier may be older than the
    # one the config records, e.g. after pulling a refresh, and generating from it would
    # silently regress the suite.
    def ensure_package!
      return download unless File.exist?(package_path)

      package = package_json(File.binread(package_path))
      return if package.values_at('version', 'date') == [version, recorded_date]

      raise Error, "#{package_path} holds #{package['version']} dated #{package['date']}, but #{CONFIG_FILE} " \
                   "records #{version} dated #{recorded_date}; run rake au_core:ci_build:download first."
    end

    def record(package)
      updated = config
      updated['ig']['version'] = package.fetch('version')
      updated['ci_build']['package_date'] = package.fetch('date')
      File.write(path(CONFIG_FILE), "#{JSON.pretty_generate(updated)}\n")
    end

    def package_json(tgz)
      Zlib::GzipReader.wrap(StringIO.new(tgz)) do |gz|
        Gem::Package::TarReader.new(gz) do |tar|
          tar.each do |entry|
            return JSON.parse(entry.read) if entry.full_name == 'package/package.json'
          end
        end
      end
      raise Error, 'package/package.json not found in the CI build package.'
    end

    def http_get(url, redirects_left = MAX_REDIRECTS)
      response = Net::HTTP.get_response(URI(url))
      case response
      when Net::HTTPSuccess
        response.body
      when Net::HTTPRedirection
        raise Error, "Too many redirects fetching #{url}" if redirects_left.zero?

        http_get(URI.join(url, response['location']).to_s, redirects_left - 1)
      else
        raise Error, "GET #{url} failed: HTTP #{response.code} #{response.message}"
      end
    end
  end
end
