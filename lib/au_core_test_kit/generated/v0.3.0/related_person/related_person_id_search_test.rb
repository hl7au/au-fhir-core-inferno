require_relative '../../../search_test'
require_relative '../../../generator/group_metadata'

module AUCoreTestKit
  module AUCoreV030
    class RelatedPersonIdSearchTest < Inferno::Test
      include AUCoreTestKit::SearchTest

      title 'Server returns valid results for RelatedPerson search by _id'
      description %(
A server SHOULD support searching by
_id on the RelatedPerson resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org/fhir/us/core//CapabilityStatement-us-core-server.html)

      )

      id :au_core_v030_related_person__id_search_test
      optional
  
      def self.properties
        @properties ||= SearchTestProperties.new(
          resource_type: 'RelatedPerson',
        search_param_names: ['_id']
        )
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:related_person_resources] ||= {}
      end

      run do
        run_search_test
      end
    end
  end
end
