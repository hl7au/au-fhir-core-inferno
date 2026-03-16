# frozen_string_literal: true

require 'inferno_suite_generator/test_modules/must_support_test'

module AUCoreTestKit
  module AUCoreV200
    class ConditionMustSupportTest < Inferno::Test
      include InfernoSuiteGenerator::MustSupportTest

      title 'All must support elements are provided in the Condition resources returned'
      description %(
        AU Core Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the AU Core Server Capability
        Statement. This test will look through the Condition resources
        found previously for the following must support elements:

        * Condition.abatement[x]
        * Condition.category
        * Condition.clinicalStatus
        * Condition.code
        * Condition.note
        * Condition.onsetDateTime
        * Condition.severity
        * Condition.subject
        * Condition.verificationStatus
      )

      id :au_core_v200_condition_must_support_test

      def resource_type
        'Condition'
      end

      def self.metadata
        @metadata ||= InfernoSuiteGenerator::Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:condition_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
