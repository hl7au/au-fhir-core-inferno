require_relative '../../../search_test'
require_relative '../../../generator/group_metadata'

module AUCoreTestKit
  module AUCoreV030
    class ServiceRequestPatientCategoryAuthoredSearchTest < Inferno::Test
      include AUCoreTestKit::SearchTest

      title 'Server returns valid results for ServiceRequest search by patient + category + authored'
      description %(
A server SHALL support searching by
patient + category + authored on the ServiceRequest resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org/fhir/us/core//CapabilityStatement-us-core-server.html)

      )

      id :au_core_v030_service_request_patient_category_authored_search_test
      input :patient_ids,
        title: 'Patient IDs',
        description: 'Comma separated list of patient IDs that in sum contain all MUST SUPPORT elements'
  
      def self.properties
        @properties ||= SearchTestProperties.new(
          resource_type: 'ServiceRequest',
        search_param_names: ['patient', 'category', 'authored'],
        possible_status_search: true,
        token_search_params: ['category']
        )
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:service_request_resources] ||= {}
      end

      run do
        run_search_test
      end
    end
  end
end
