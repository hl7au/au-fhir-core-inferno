# frozen_string_literal: true

require 'inferno_suite_generator/search_test'
require 'inferno_suite_generator/search_test_properties'
require 'inferno_suite_generator/generator/group_metadata'
require 'inferno_suite_generator/helpers'

module AUCoreTestKit
  module AUCoreV100
    class PractitionerRoleSpecialtySearchTest < Inferno::Test
      include InfernoSuiteGenerator::SearchTest

      title '(SHOULD) Server returns valid results for PractitionerRole search by specialty'
      description %(
A server SHOULD support searching by
specialty on the PractitionerRole resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html)

      )

      id :au_core_v100_practitioner_role_specialty_search_test
      optional

      def self.properties
        @properties ||= InfernoSuiteGenerator::SearchTestProperties.new(
          resource_type: 'PractitionerRole',
          search_param_names: ['specialty'],
          includes: [{ 'parameter' => 'PractitionerRole:practitioner', 'target_resource' => 'Practitioner', 'paths' => ['practitioner'] }],
          token_search_params: ['specialty']
        )
      end

      def self.metadata
        @metadata ||= InfernoSuiteGenerator::Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:practitioner_role_resources] ||= {}
      end

      run do
        run_search_test
      end
    end
  end
end
