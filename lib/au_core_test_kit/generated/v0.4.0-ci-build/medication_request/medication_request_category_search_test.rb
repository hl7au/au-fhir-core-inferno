require_relative '../../../search_test'
require_relative '../../../generator/group_metadata'

module AUCoreTestKit
  module AUCoreV040_CI_BUILD
    class MedicationRequestCategorySearchTest < Inferno::Test
      include AUCoreTestKit::SearchTest

      title 'Server returns valid results for MedicationRequest search by category'
      description %(
A server MAY support searching by
category on the MedicationRequest resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

If any MedicationRequest resources use external references to
Medications, the search will be repeated with
`_include=MedicationRequest:medication`.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html)

      )

      id :au_core_v040_ci_build_medication_request_category_search_test
      optional
  
      def self.properties
        @properties ||= SearchTestProperties.new(
          resource_type: 'MedicationRequest',
        search_param_names: ['category'],
        possible_status_search: true,
        test_medication_inclusion: true,
        token_search_params: ['category']
        )
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:medication_request_resources] ||= {}
      end

      run do
        run_search_test
      end
    end
  end
end
