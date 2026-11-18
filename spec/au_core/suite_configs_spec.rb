# frozen_string_literal: true

require_relative '../../lib/au_core_test_kit/suite_configs'

RSpec.describe AUCoreTestKit::SuiteConfigs do
  described_class.each do |entry|
    describe entry.version_file do
      it "names a suite the kit loads (#{entry.suite_id})" do
        expect(Inferno::Repositories::TestSuites.new.find(entry.suite_id)).not_to be_nil
      end

      it 'points at an existing generated folder' do
        expect(Dir).to exist(entry.generated_dir)
      end

      it 'reads the CapabilityStatement from its IG package' do
        expect(entry.capability_statement).to include('resourceType' => 'CapabilityStatement')
      end
    end
  end

  describe '.deep_merge' do
    it 'does not carry keys from one merge into the next' do
      basic = { 'configs' => { 'resources' => {} } }
      described_class.deep_merge(basic, { 'configs' => { 'resources' => { 'RelatedPerson' => { 'skip' => true } } } })

      expect(described_class.deep_merge(basic, {})).to eq(basic)
    end
  end
end
