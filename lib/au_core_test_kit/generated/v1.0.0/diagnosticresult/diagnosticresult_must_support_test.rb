# frozen_string_literal: true

require 'inferno_suite_generator/must_support_test'

module AUCoreTestKit
  module AUCoreV100
    class DiagnosticresultMustSupportTest < Inferno::Test
      include InfernoSuiteGenerator::MustSupportTest

      title 'All must support elements are provided in the Observation resources returned'
      description %(
        AU Core Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the AU Core Server Capability
        Statement. This test will look through the Observation resources
        found previously for the following must support elements:

        * Observation.bodySite
        * Observation.category
        * Observation.code
        * Observation.component
        * Observation.component.code
        * Observation.component.value[x]
        * Observation.effective[x]
        * Observation.hasMember
        * Observation.performer
        * Observation.status
        * Observation.subject
        * Observation.value[x]
      )

      id :au_core_v100_diagnosticresult_must_support_test

      def resource_type
        'Observation'
      end

      def self.metadata
        @metadata ||= InfernoSuiteGenerator::Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:diagnosticresult_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
