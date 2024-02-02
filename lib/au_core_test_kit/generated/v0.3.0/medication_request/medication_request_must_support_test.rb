require_relative '../../../must_support_test'

module AUCoreTestKit
  module AUCoreV030
    class MedicationRequestMustSupportTest < Inferno::Test
      include AUCoreTestKit::MustSupportTest

      title 'All must support elements are provided in the MedicationRequest resources returned'
      description %(
        AU Core Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the AU Core Server Capability
        Statement. This test will look through the MedicationRequest resources
        found previously for the following must support elements:

        * MedicationRequest.authoredOn
        * MedicationRequest.category
        * MedicationRequest.dispenseRequest
        * MedicationRequest.dispenseRequest.numberOfRepeatsAllowed
        * MedicationRequest.dispenseRequest.quantity
        * MedicationRequest.dispenseRequest.validityPeriod
        * MedicationRequest.dosageInstruction
        * MedicationRequest.encounter
        * MedicationRequest.identifier
        * MedicationRequest.intent
        * MedicationRequest.medication[x]
        * MedicationRequest.medication[x]:medicationCodeableConcept.coding:amt
        * MedicationRequest.medication[x]:medicationCodeableConcept.coding:pbs
        * MedicationRequest.note
        * MedicationRequest.reasonCode
        * MedicationRequest.requester
        * MedicationRequest.status
        * MedicationRequest.subject
        * MedicationRequest.substitution
        * MedicationRequest.substitution.allowed[x]
      )

      id :au_core_v030_medication_request_must_support_test

      def resource_type
        'MedicationRequest'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:medication_request_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
