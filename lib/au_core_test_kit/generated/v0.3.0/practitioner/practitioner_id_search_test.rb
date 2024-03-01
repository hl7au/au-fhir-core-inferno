require_relative '../../../search_test'
require_relative '../../../generator/group_metadata'

module AUCoreTestKit
  module AUCoreV030
    class PractitionerIdSearchTest < Inferno::Test
      include AUCoreTestKit::SearchTest

      title 'Server returns valid results for Practitioner search by _id'
      description %(
A server SHALL support searching by
_id on the Practitioner resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

Because this is the first search of the sequence, resources in the
response will be used for subsequent tests.

Additionally, this test will check that GET and POST search methods
return the same number of results. Search by POST is required by the
FHIR R4 specification, and these tests interpret search by GET as a
requirement of AU Core v0.3.0.

[AU Core Server CapabilityStatement](http://hl7.org/fhir/us/core//CapabilityStatement-us-core-server.html)

      )

      id :au_core_v030_practitioner__id_search_test
      input :practitioner_ids,
        title: 'Practitioner IDs',
        description: 'Comma separated list of practitioner IDs that in sum contain all MUST SUPPORT elements',
        default: 'bradley-jill, surgeon-david, nurse-nancy, pharmacist, cardy-igist, levin-henry, sandyson-sandy, bobrester-bob, primary-peter, bobrester-bob-tc-1.21'
  
      def self.properties
        @properties ||= SearchTestProperties.new(
          first_search: true,
        resource_type: 'Practitioner',
        search_param_names: ['_id'],
        test_post_search: true
        )
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:practitioner_resources] ||= {}
      end

      run do
        run_search_test
      end
    end
  end
end
