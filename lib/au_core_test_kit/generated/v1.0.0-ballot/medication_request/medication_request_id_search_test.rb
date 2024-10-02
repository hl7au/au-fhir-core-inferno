# frozen_string_literal: true

require_relative '../../../search_test'
require_relative '../../../generator/group_metadata'
require_relative '../../../helpers'

module AUCoreTestKit
  module AUCoreV100_BALLOT
    class MedicationRequestIdSearchTest < Inferno::Test
      include AUCoreTestKit::SearchTest

      title '(SHALL) Server returns valid results for MedicationRequest search by _id'
      description %(
A server SHALL support searching by
_id on the MedicationRequest resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

If any MedicationRequest resources use external references to
Medications, the search will be repeated with
`_include=MedicationRequest:medication`.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html)

      )

      id :au_core_v100_ballot_medication_request__id_search_test
      def self.properties
        @properties ||= SearchTestProperties.new(
          resource_type: 'MedicationRequest',
          search_param_names: ['_id'],
          possible_status_search: true,
          test_medication_inclusion: true,
          includes: [{ 'parameter' => 'MedicationRequest:medication', 'target_resource' => 'Medication', 'paths' => ['medicationReference'] }]
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
