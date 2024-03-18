require_relative '../../../must_support_test'

module AUCoreTestKit
  module AUCoreV030_BALLOT
    class MedicationStatementMustSupportTest < Inferno::Test
      include AUCoreTestKit::MustSupportTest

      title 'All must support elements are provided in the MedicationStatement resources returned'
      description %(
        AU Core Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the AU Core Server Capability
        Statement. This test will look through the MedicationStatement resources
        found previously for the following must support elements:

        * MedicationStatement.basedOn
        * MedicationStatement.category
        * MedicationStatement.context
        * MedicationStatement.dateAsserted
        * MedicationStatement.dosage
        * MedicationStatement.effective[x]
        * MedicationStatement.informationSource
        * MedicationStatement.medication[x]
        * MedicationStatement.medication[x]:medicationCodeableConcept.coding:amt
        * MedicationStatement.medication[x]:medicationCodeableConcept.coding:pbs
        * MedicationStatement.note
        * MedicationStatement.reasonCode
        * MedicationStatement.status
        * MedicationStatement.statusReason
        * MedicationStatement.subject
      )

      id :au_core_v030_ballot_medication_statement_must_support_test

      def resource_type
        'MedicationStatement'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:medication_statement_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
