require_relative '../../../search_test'
require_relative '../../../generator/group_metadata'

module USCoreTestKit
  module USCoreV030
    class HealthcareServiceLocationSearchTest < Inferno::Test
      include USCoreTestKit::SearchTest

      title 'Server returns valid results for HealthcareService search by location'
      description %(
A server SHOULD support searching by
location on the HealthcareService resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[US Core Server CapabilityStatement](http://hl7.org/fhir/us/core//CapabilityStatement-us-core-server.html)

      )

      id :us_core_v030_healthcare_service_location_search_test
      optional
  
      def self.properties
        @properties ||= SearchTestProperties.new(
          resource_type: 'HealthcareService',
        search_param_names: ['location']
        )
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:healthcare_service_resources] ||= {}
      end

      run do
        run_search_test
      end
    end
  end
end
