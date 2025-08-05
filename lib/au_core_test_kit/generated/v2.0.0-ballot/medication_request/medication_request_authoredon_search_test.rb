# frozen_string_literal: true

require_relative '../../../search_test'
require_relative '../../../generator/group_metadata'
require_relative '../../../helpers'

module AUCoreTestKit
  module AUCoreV200_BALLOT
    class MedicationRequestAuthoredonSearchTest < Inferno::Test
      include AUCoreTestKit::SearchTest

      title '(MAY) Server returns valid results for MedicationRequest search by authoredon'
      description %(
A server MAY support searching by
authoredon on the MedicationRequest resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

If any MedicationRequest resources use external references to
Medications, the search will be repeated with
`_include=MedicationRequest:medication`.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html)

      )

      id :au_core_v200_ballot_medication_request_authoredon_search_test
      optional

      def self.properties
        @properties ||= SearchTestProperties.new(
          resource_type: 'MedicationRequest',
          search_param_names: ['authoredon'],
          possible_status_search: true,
          test_medication_inclusion: true,
          includes: [{ 'parameter' => 'MedicationRequest:medication', 'target_resource' => 'Medication', 'paths' => ['medicationReference'] }],
          params_with_comparators: ['authoredon']
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
