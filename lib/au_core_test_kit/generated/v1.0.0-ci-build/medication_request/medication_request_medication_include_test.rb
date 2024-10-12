# frozen_string_literal: true

require_relative '../../../search_test'
require_relative '../../../generator/group_metadata'
require_relative '../../../helpers'

module AUCoreTestKit
  module AUCoreV100_CI_BUILD
    class MedicationRequestMedicationIncludeTest < Inferno::Test
      include AUCoreTestKit::SearchTest
      title 'Server returns Medication resources from MedicationRequest search by patient and MedicationRequest:medication'
      description %(
This test will perform a search by patient and MedicationRequest:medication

Test will pass if a Medication resources are found in the response.

      )

      id :au_core_v100_ci_build_medication_request_Medication_search_test
      optional

      input :patient_ids,
            title: 'Patient IDs',
            description: 'Comma separated list of patient IDs that in sum contain all MUST SUPPORT elements',
            default: 'baratz-toni, irvine-ronny-lawrence, italia-sofia, howe-deangelo, hayes-arianne, baby-banks-john, banks-mia-leanne'

      def self.properties
        @properties ||= SearchTestProperties.new(
          resource_type: 'MedicationRequest',
          saves_delayed_references: true,
          search_param_names: ['patient'],
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
        run_include_test
      end
    end
  end
end
