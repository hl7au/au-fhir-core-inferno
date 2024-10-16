# frozen_string_literal: true

require_relative '../../../search_test'
require_relative '../../../generator/group_metadata'
require_relative '../../../helpers'

module AUCoreTestKit
  module AUCoreV100_BALLOT
    class MedicationRequestPatientIntentIncludeMedicationTest < Inferno::Test
      include AUCoreTestKit::SearchTest
      title 'Server returns Medication resources from MedicationRequest search by patient, intent and MedicationRequest:medication'
      description %(
This test will perform a search by patient, intent and the _include=MedicationRequest:medication

Test will pass if a Medication resources are found in the response.

      )

      id :au_core_v100_ballot_medication_request_patient_intent_include_patient_intent_search_test
      optional

      input :patient_ids,
            title: 'Patient IDs',
            description: 'Comma separated list of patient IDs that in sum contain all MUST SUPPORT elements',
            default: 'baratz-toni, irvine-ronny-lawrence, italia-sofia, howe-deangelo, hayes-arianne, baby-banks-john, banks-mia-leanne'

      def self.properties
        @properties ||= SearchTestProperties.new(
          resource_type: 'MedicationRequest',
          search_param_names: %w[patient intent],
          includes: [{ 'parameter' => 'MedicationRequest:medication', 'target_resource' => 'Medication', 'paths' => ['medicationReference'] }],
          use_any_data_for_search: true
        )
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:medication_request_resources] ||= {}
      end

      run do
        run_include_test
      end
    end
  end
end
