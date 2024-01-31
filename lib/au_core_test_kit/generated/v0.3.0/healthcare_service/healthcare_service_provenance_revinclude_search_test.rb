require_relative '../../../search_test'
require_relative '../../../generator/group_metadata'

module USCoreTestKit
  module USCoreV030
    class HealthcareServiceProvenanceRevincludeSearchTest < Inferno::Test
      include USCoreTestKit::SearchTest

      title 'Server returns Provenance resources from HealthcareService search by name + revInclude:Provenance:target'
      description %(
        A server SHALL be capable of supporting _revIncludes:Provenance:target.

        This test will perform a search by name + revInclude:Provenance:target and
        will pass if a Provenance resource is found in the response.
      %)

      id :us_core_v030_healthcare_service_provenance_revinclude_search_test
  
      def properties
        @properties ||= SearchTestProperties.new(
          resource_type: 'HealthcareService',
        search_param_names: ['name']
        )
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml')))
      end

      def self.provenance_metadata
        @provenance_metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, '..', 'provenance', 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:healthcare_service_resources] ||= {}
      end

      def scratch_provenance_resources
        scratch[:provenance_resources] ||= {}
      end

      run do
        run_provenance_revinclude_search_test
      end
    end
  end
end
