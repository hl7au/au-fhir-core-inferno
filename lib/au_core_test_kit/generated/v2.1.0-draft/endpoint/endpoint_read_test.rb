# frozen_string_literal: true

require 'inferno_suite_generator/test_modules/read_test'

module AUCoreTestKit
  module AUCoreV210_DRAFT
    class EndpointReadTest < Inferno::Test
      include InfernoSuiteGenerator::ReadTest

      title '(SHALL) Server returns correct Endpoint resource from Endpoint read interaction'
      description 'A server SHALL support the Endpoint read interaction.'

      input :endpoint_ids,
            title: 'Endpoint IDs',
            description: 'Comma separated list of endpoint IDs that in sum contain all MUST SUPPORT elements',
            default: '',
            optional: true

      id :au_core_v210_draft_endpoint_read_test

      def self.demodata
        @demodata ||= InfernoSuiteGenerator::Generator::IGDemodata.new(
          YAML.load_file(File.join(File.dirname(__dir__), 'demodata.yml'), aliases: true)
        )
      end

      def resource_type
        'Endpoint'
      end

      def scratch_resources
        scratch[:endpoint_resources] ||= {}
      end

      run do
        perform_read_test(scratch.dig(:references, 'Endpoint'))
      end
    end
  end
end
