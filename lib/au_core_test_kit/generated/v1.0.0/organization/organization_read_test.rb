# frozen_string_literal: true

require 'inferno_suite_generator/read_test'

module AUCoreTestKit
  module AUCoreV100
    class OrganizationReadTest < Inferno::Test
      include InfernoSuiteGenerator::ReadTest

      title '(SHALL) Server returns correct Organization resource from Organization read interaction'
      description 'A server SHALL support the Organization read interaction.'

      input :organization_ids,
            title: 'Organization IDs',
            description: 'Comma separated list of organization IDs that in sum contain all MUST SUPPORT elements',
            default: 'dva-au, organization-medical-center-tc',
            optional: true

      id :au_core_v100_organization_read_test

      def resource_type
        'Organization'
      end

      def scratch_resources
        scratch[:organization_resources] ||= {}
      end

      run do
        perform_read_test(scratch.dig(:references, 'Organization'))
      end
    end
  end
end
