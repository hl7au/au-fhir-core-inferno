# frozen_string_literal: true

require 'inferno_suite_generator/reference_resolution_test'

module AUCoreTestKit
  module AUCoreV100
    class MedicationRequestReferenceResolutionTest < Inferno::Test
      include InfernoSuiteGenerator::ReferenceResolutionTest

      title 'MustSupport references within MedicationRequest resources are valid'
      description %(
        This test will attempt to read external references provided within elements
        marked as 'MustSupport', if any are available.

        It verifies that at least one external reference for each MustSupport Reference element
        can be accessed by the test client, and conforms to corresponding AU Core profile.

        Elements which may provide external references include:

        * MedicationRequest.encounter
        * MedicationRequest.medication[x]
        * MedicationRequest.reasonReference
        * MedicationRequest.requester
        * MedicationRequest.subject
      )

      id :au_core_v100_medication_request_reference_resolution_test

      def resource_type
        'MedicationRequest'
      end

      def self.metadata
        @metadata ||= InfernoSuiteGenerator::Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:medication_request_resources] ||= {}
      end

      run do
        perform_reference_resolution_test(scratch_resources[:all])
      end
    end
  end
end
