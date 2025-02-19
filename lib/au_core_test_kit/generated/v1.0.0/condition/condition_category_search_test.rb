# frozen_string_literal: true

require 'inferno_suite_generator/search_test'
require 'inferno_suite_generator/search_test_properties'
require 'inferno_suite_generator/generator/group_metadata'
require 'inferno_suite_generator/helpers'

module AUCoreTestKit
  module AUCoreV100
    class ConditionCategorySearchTest < Inferno::Test
      include InfernoSuiteGenerator::SearchTest

      title '(MAY) Server returns valid results for Condition search by category'
      description %(
A server MAY support searching by
category on the Condition resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html)

      )

      id :au_core_v100_condition_category_search_test
      optional

      def self.properties
        @properties ||= InfernoSuiteGenerator::SearchTestProperties.new(
          resource_type: 'Condition',
          search_param_names: ['category'],
          possible_status_search: true,
          token_search_params: ['category']
        )
      end

      def self.metadata
        @metadata ||= InfernoSuiteGenerator::Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:condition_resources] ||= {}
      end

      run do
        run_search_test
      end
    end
  end
end
