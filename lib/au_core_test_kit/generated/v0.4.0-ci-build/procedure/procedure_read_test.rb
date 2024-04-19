# frozen_string_literal: true

require_relative '../../../read_test'

module AUCoreTestKit
  module AUCoreV040_CI_BUILD
    class ProcedureReadTest < Inferno::Test
      include AUCoreTestKit::ReadTest

      title 'Server returns correct Procedure resource from Procedure read interaction'
      description 'A server SHALL support the Procedure read interaction.'

      id :au_core_v040_ci_build_procedure_read_test

      def resource_type
        'Procedure'
      end

      def scratch_resources
        scratch[:procedure_resources] ||= {}
      end

      run do
        perform_read_test(all_scratch_resources)
      end
    end
  end
end
