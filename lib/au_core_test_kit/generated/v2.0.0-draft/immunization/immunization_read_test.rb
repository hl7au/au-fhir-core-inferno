# frozen_string_literal: true

require_relative '../../../read_test'

module AUCoreTestKit
  module AUCoreV200_DRAFT
    class ImmunizationReadTest < Inferno::Test
      include AUCoreTestKit::ReadTest

      title '(SHALL) Server returns correct Immunization resource from Immunization read interaction'
      description 'A server SHALL support the Immunization read interaction.'

      id :au_core_v200_draft_immunization_read_test

      def resource_type
        'Immunization'
      end

      def scratch_resources
        scratch[:immunization_resources] ||= {}
      end

      run do
        perform_read_test(all_scratch_resources)
      end
    end
  end
end
