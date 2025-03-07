# frozen_string_literal: true

require_relative '../../../must_support_test'

module AUCoreTestKit
  module AUCoreV110_PREVIEW
    class MedicationStatementMustSupportTest < Inferno::Test
      include AUCoreTestKit::MustSupportTest

      title 'All must support elements are provided in the MedicationStatement resources returned'
      description %(
        AU Core Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the AU Core Server Capability
        Statement. This test will look through the MedicationStatement resources
        found previously for the following must support elements:

        * MedicationStatement.dateAsserted
        * MedicationStatement.dosage
        * MedicationStatement.effective[x]
        * MedicationStatement.medication[x]
        * MedicationStatement.reasonCode
        * MedicationStatement.reasonReference
        * MedicationStatement.status
        * MedicationStatement.subject
      )

      id :au_core_v110_preview_medication_statement_must_support_test

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
