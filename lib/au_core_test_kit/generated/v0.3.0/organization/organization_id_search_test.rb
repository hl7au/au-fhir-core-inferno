require_relative '../../../search_test'
require_relative '../../../generator/group_metadata'

module USCoreTestKit
  module USCoreV030
    class OrganizationIdSearchTest < Inferno::Test
      include USCoreTestKit::SearchTest

      title 'Server returns valid results for Organization search by _id'
      description %(
A server SHOULD support searching by
_id on the Organization resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[US Core Server CapabilityStatement](http://hl7.org/fhir/us/core//CapabilityStatement-us-core-server.html)

      )

      id :us_core_v030_organization__id_search_test
      optional
  
      def self.properties
        @properties ||= SearchTestProperties.new(
          resource_type: 'Organization',
        search_param_names: ['_id']
        )
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:organization_resources] ||= {}
      end

      run do
        run_search_test
      end
    end
  end
end
