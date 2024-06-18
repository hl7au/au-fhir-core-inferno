# frozen_string_literal: true

require_relative '../../../read_test'

module AUCoreTestKit
  module AUCoreV040_CI_BUILD
    class PractitionerReadTest < Inferno::Test
      include AUCoreTestKit::ReadTest

      title '(SHALL) Server returns correct Practitioner resource from Practitioner read interaction'
      description 'A server SHALL support the Practitioner read interaction.'

      id :au_core_v040_ci_build_practitioner_read_test

      def resource_type
        'Practitioner'
      end

      def scratch_resources
        scratch[:practitioner_resources] ||= {}
      end

      run do
        perform_read_test(scratch.dig(:references, 'Practitioner'))
      end
    end
  end
end
