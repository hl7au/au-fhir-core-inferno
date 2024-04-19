# frozen_string_literal: true

require_relative '../../../read_test'

module AUCoreTestKit
  module AUCoreV030_BALLOT
    class MedicationStatementReadTest < Inferno::Test
      include AUCoreTestKit::ReadTest

      title 'Server returns correct MedicationStatement resource from MedicationStatement read interaction'
      description 'A server SHALL support the MedicationStatement read interaction.'

      id :au_core_v030_ballot_medication_statement_read_test

      def resource_type
        'MedicationStatement'
      end

      def scratch_resources
        scratch[:medication_statement_resources] ||= {}
      end

      run do
        perform_read_test(all_scratch_resources)
      end
    end
  end
end
