# frozen_string_literal: true

require 'inferno_suite_generator/test_modules/must_support_test'

module AUCoreTestKit
  module AUCoreV210_DRAFT
    class MedicationDispenseMustSupportTest < Inferno::Test
      include InfernoSuiteGenerator::MustSupportTest

      title 'All must support elements are provided in the MedicationDispense resources returned'
      description %(
        AU Core Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the AU Core Server Capability
        Statement. This test will look through the MedicationDispense resources
        found previously for the following must support elements:

        * MedicationDispense.authorizingPrescription
        * MedicationDispense.dosageInstruction
        * MedicationDispense.dosageInstruction.text
        * MedicationDispense.medication[x]
        * MedicationDispense.medication[x]:medicationCodeableConcept
        * MedicationDispense.medication[x]:medicationReference
        * MedicationDispense.note
        * MedicationDispense.performer
        * MedicationDispense.performer.actor
        * MedicationDispense.quantity
        * MedicationDispense.status
        * MedicationDispense.subject
        * MedicationDispense.whenPrepared
      )

      id :au_core_v210_draft_medication_dispense_must_support_test

      def resource_type
        'MedicationDispense'
      end

      def self.metadata
        @metadata ||= InfernoSuiteGenerator::Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:medication_dispense_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
