# frozen_string_literal: true

require_relative '../../../search_test'
require_relative '../../../generator/group_metadata'
require_relative '../../../helpers'

module AUCoreTestKit
  module AUCoreV030_BALLOT
    class MedicationRequestIntentSearchTest < Inferno::Test
      include AUCoreTestKit::SearchTest

      title '(MAY) Server returns valid results for MedicationRequest search by intent'
      description %(
A server MAY support searching by
intent on the MedicationRequest resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

If any MedicationRequest resources use external references to
Medications, the search will be repeated with
`_include=MedicationRequest:medication`.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)

      )

      id :au_core_v030_ballot_medication_request_intent_search_test
      optional

      input :count_limit,
            title: 'Use _count search parameter for search tests.',
            description: 'If your server has a lot of data, you can decrease the number of resources in server responses by limiting via _count.',
            type: 'radio',
            default: 'false',
            options: {
              list_options: [
                {
                  label: '1',
                  value: '1'
                },
                {
                  label: '10',
                  value: '10'
                },
                {
                  label: '20',
                  value: '20'
                },
                {
                  label: '50',
                  value: '50'
                },
                {
                  label: '100',
                  value: '100'
                },
                {
                  label: 'False',
                  value: 'false'
                }
              ]
            }
      def self.properties
        @properties ||= SearchTestProperties.new(
          resource_type: 'MedicationRequest',
          search_param_names: ['intent'],
          possible_status_search: true,
          test_medication_inclusion: true
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
