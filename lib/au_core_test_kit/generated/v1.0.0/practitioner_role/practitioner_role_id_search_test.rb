# frozen_string_literal: true

require 'inferno_suite_generator/search_test'
require 'inferno_suite_generator/search_test_properties'
require 'inferno_suite_generator/generator/group_metadata'
require 'inferno_suite_generator/helpers'

module AUCoreTestKit
  module AUCoreV100
    class PractitionerRoleIdSearchTest < Inferno::Test
      include InfernoSuiteGenerator::SearchTest

      title '(SHOULD) Server returns valid results for PractitionerRole search by _id'
      description %(
A server SHOULD support searching by
_id on the PractitionerRole resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

Because this is the first search of the sequence, resources in the
response will be used for subsequent tests.

Additionally, this test will check that GET and POST search methods
return the same number of results. Search by POST is required by the
FHIR R4 specification, and these tests interpret search by GET as a
requirement of AU Core v1.0.0.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html)

      )

      id :au_core_v100_practitioner_role__id_search_test
      optional

      def self.properties
        @properties ||= InfernoSuiteGenerator::SearchTestProperties.new(
          first_search: true,
          resource_type: 'PractitionerRole',
          search_param_names: ['_id'],
          saves_delayed_references: true,
          includes: [{ 'parameter' => 'PractitionerRole:practitioner', 'target_resource' => 'Practitioner', 'paths' => ['practitioner'] }],
          test_post_search: true
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
