# frozen_string_literal: true

require_relative '../../support/suite_rule_helpers'

RSpec.describe 'Suite Rule: each suite validates against its own IG version' do
  include SuiteRuleHelpers

  AUCoreTestKit::SuiteConfigs.each do |entry|
    it "holds for #{entry.suite_id}" do
      expected = ["#{entry.merged.dig('ig', 'id')}##{entry.ig_version}"]
      validators = suite_for(entry).fhir_validators.values.flatten

      expect(validators).not_to be_empty
      validators.each do |validator|
        expect(validator.validation_context.definition[:igs]).to eq(expected)
      end
    end
  end
end
