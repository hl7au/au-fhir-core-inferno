# frozen_string_literal: true

require 'inferno_suite_generator/test_modules/search_test'
require 'inferno_suite_generator/core/group_metadata'
require 'inferno_suite_generator/utils/helpers'

module AUCoreTestKit
  module AUCoreV210_DRAFT
    class EndpointConnectionTypeSearchTest < Inferno::Test
      include InfernoSuiteGenerator::SearchTest

      title '(MAY) Server returns valid results for Endpoint search by connection-type'
      description %(
A server MAY support searching by
connection-type on the Endpoint resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/CapabilityStatement/au-core-responder)

      )

      id :au_core_v210_draft_endpoint_connection_type_search_test
      optional

      def self.demodata
        @demodata ||= InfernoSuiteGenerator::Generator::IGDemodata.new(
          YAML.load_file(File.join(File.dirname(__dir__), 'demodata.yml'), aliases: true)
        )
      end

      def self.properties
        @properties ||= InfernoSuiteGenerator::SearchTestProperties.new(
          resource_type: 'Endpoint',
          search_param_names: ['connection-type'],
          possible_status_search: true,
          token_search_params: ['connection-type']
        )
      end

      def self.metadata
        @metadata ||= InfernoSuiteGenerator::Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:endpoint_resources] ||= {}
      end

      def keep_all_search_results?
        false
      end

      run do
        run_search_test
      end
    end
  end
end
