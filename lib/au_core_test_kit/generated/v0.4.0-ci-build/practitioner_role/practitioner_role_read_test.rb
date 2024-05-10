# frozen_string_literal: true

require_relative '../../../read_test'

module AUCoreTestKit
  module AUCoreV040_CI_BUILD
    class PractitionerRoleReadTest < Inferno::Test
      include AUCoreTestKit::ReadTest

      title 'Server returns correct PractitionerRole resource from PractitionerRole read interaction'
      description 'A server SHALL support the PractitionerRole read interaction.'

      id :au_core_v040_ci_build_practitioner_role_read_test

      def resource_type
        'PractitionerRole'
      end

      def scratch_resources
        scratch[:practitioner_role_resources] ||= {}
      end

      run do
        perform_read_test(scratch.dig(:references, 'PractitionerRole'))
      end
    end
  end
end
