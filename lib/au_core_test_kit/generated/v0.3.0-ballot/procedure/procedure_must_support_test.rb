# frozen_string_literal: true

require_relative '../../../must_support_test'

module AUCoreTestKit
  module AUCoreV030_BALLOT
    class ProcedureMustSupportTest < Inferno::Test
      include AUCoreTestKit::MustSupportTest

      title 'All must support elements are provided in the Procedure resources returned'
      description %(
        AU Core Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the AU Core Server Capability
        Statement. This test will look through the Procedure resources
        found previously for the following must support elements:

        * Procedure.asserter
        * Procedure.bodySite
        * Procedure.category
        * Procedure.code
        * Procedure.encounter
        * Procedure.note
        * Procedure.performed[x]
        * Procedure.reasonCode
        * Procedure.reasonReference
        * Procedure.recorder
        * Procedure.status
        * Procedure.statusReason
        * Procedure.subject
      )

      id :au_core_v030_ballot_procedure_must_support_test

      def resource_type
        'Procedure'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:procedure_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
