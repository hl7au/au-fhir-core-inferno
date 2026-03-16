# frozen_string_literal: true

require 'inferno_suite_generator/test_modules/read_test'

module AUCoreTestKit
  module AUCoreV200
    class OrganizationReadTest < Inferno::Test
      include InfernoSuiteGenerator::ReadTest

      title '(SHALL) Server returns correct Organization resource from Organization read interaction'
      description 'A server SHALL support the Organization read interaction.'

      input :organization_ids,
            title: 'Organization IDs',
            description: 'Comma separated list of organization IDs that in sum contain all MUST SUPPORT elements',
            default: 'dva-au, organization-medical-center-tc',
            optional: true

      id :au_core_v200_organization_read_test

      def self.demodata
        @demodata ||= InfernoSuiteGenerator::Generator::IGDemodata.new(
          YAML.load_file(File.join(File.dirname(__dir__), 'demodata.yml'), aliases: true)
        )
      end

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
