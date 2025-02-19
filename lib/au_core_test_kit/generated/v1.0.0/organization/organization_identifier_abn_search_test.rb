# frozen_string_literal: true

require 'inferno_suite_generator/special_identifier_search_test'
require 'inferno_suite_generator/generator/group_metadata'
require 'inferno_suite_generator/search_test_properties'

module AUCoreTestKit
  module AUCoreV100
    class OrganizationIdentifierABNSearchTest < Inferno::Test
      include InfernoSuiteGenerator::SpecialIdentifierSearchTest

      title '(SHOULD) Server returns valid results for Organization search by identifier (ABN)'
      description %(A server SHOULD support searching by
identifier (ABN) on the Organization resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html)
)

      id :au_core_v100_organization_identifier_abn_search_test
      optional

      def self.properties
        @properties ||= InfernoSuiteGenerator::SearchTestProperties.new(
          resource_type: 'Organization',
          search_param_names: ['identifier'],
          token_search_params: ['identifier'],
          target_identifier: { display: 'ABN', url: 'http://hl7.org.au/id/abn' }
        )
      end

      def self.metadata
        @metadata ||= InfernoSuiteGenerator::Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:organization_resources] ||= {}
      end

      run do
        run_special_identifier_search_test
      end
    end
  end
end
