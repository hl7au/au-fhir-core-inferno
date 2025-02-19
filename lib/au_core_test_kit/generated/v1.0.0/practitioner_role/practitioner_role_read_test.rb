# frozen_string_literal: true

require 'inferno_suite_generator/read_test'

module AUCoreTestKit
  module AUCoreV100
    class PractitionerRoleReadTest < Inferno::Test
      include InfernoSuiteGenerator::ReadTest

      title '(SHALL) Server returns correct PractitionerRole resource from PractitionerRole read interaction'
      description 'A server SHALL support the PractitionerRole read interaction.'

      input :practitioner_role_ids,
            title: 'PractitionerRole IDs',
            description: 'Comma separated list of practitioner role IDs that in sum contain all MUST SUPPORT elements',
            default: 'cardiologist-sallie-sutherland, bobrester-bob-gp',
            optional: true

      id :au_core_v100_practitioner_role_read_test

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
