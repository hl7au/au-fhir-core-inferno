# frozen_string_literal: true

require_relative '../../../search_test'
require_relative '../../../generator/group_metadata'
require_relative '../../../helpers'

module AUCoreTestKit
  module AUCoreV050_CI_BUILD
    class MedicationRequestPatientIntentStatusSearchTest < Inferno::Test
      include AUCoreTestKit::SearchTest

      title '(SHALL) Server returns valid results for MedicationRequest search by patient + intent + status'
      description %(
A server SHALL support searching by
patient + intent + status on the MedicationRequest resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

If any MedicationRequest resources use external references to
Medications, the search will be repeated with
`_include=MedicationRequest:medication`.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html)

      )

      id :au_core_v050_ci_build_medication_request_patient_intent_status_search_test
      input :patient_ids,
            title: 'Patient IDs',
            description: 'Comma separated list of patient IDs that in sum contain all MUST SUPPORT elements',
            default: 'baratz-toni, irvine-ronny-lawrence, italia-sofia, howe-deangelo, hayes-arianne, baby-banks-john, banks-mia-leanne'

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
          search_param_names: %w[patient intent status],
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
