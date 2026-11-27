# frozen_string_literal: true

require_relative '../../rakelib/scenarios/suites'

RSpec.describe AUCoreTestKit::Scenarios::Suites do
  repo_root = File.expand_path('../..', __dir__)
  ids = %w[au_core_v100 au_core_v200 au_core_v210_draft au_core_v300_ballot1]

  it 'lists the four versioned suites in order' do
    expect(described_class.all.map(&:suite_id)).to eq(ids)
  end

  it 'gives the config file, IG id and version and Scenario directory of each suite' do
    suite = described_class.find('au_core_v300_ballot1')

    expect(suite).to have_attributes(
      config_file: 'config.300-ballot1.json',
      ig_id: 'hl7.fhir.au.core',
      ig_version: '3.0.0-ballot1',
      package_path: 'lib/au_core_test_kit/igs/3.0.0-ballot1.tgz',
      scenario_dir: 'spec/fixtures/stub_server/au_core_v300_ballot1/'
    )
  end

  ids.each do |id|
    it "lists #{id} as a registered Inferno suite with its IG package on disk" do
      suite = described_class.find(id)

      expect(Inferno::Repositories::TestSuites.new.find(id)).to be_present
      expect(File).to exist(File.join(repo_root, suite.package_path))
    end
  end

  %w[au_core_ci_build validations].each do |id|
    it "raises with the known ids for #{id}" do
      expect { described_class.find(id) }.to raise_error(ArgumentError, /#{ids.join(', ')}/)
    end
  end
end
