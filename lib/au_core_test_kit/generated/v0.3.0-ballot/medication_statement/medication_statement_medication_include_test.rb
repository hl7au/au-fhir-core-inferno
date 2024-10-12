# frozen_string_literal: true

require_relative '../../../search_test'
require_relative '../../../generator/group_metadata'
require_relative '../../../helpers'

module AUCoreTestKit
  module AUCoreV030_BALLOT
    class MedicationStatementMedicationIncludeTest < Inferno::Test
      include AUCoreTestKit::SearchTest
      title 'Server returns Medication resources from MedicationStatement search by patient and MedicationStatement:medication'
      description %(
This test will perform a search by patient and MedicationStatement:medication

Test will pass if a Medication resources are found in the response.

      )

      id :au_core_v030_ballot_medication_statement_Medication_search_test
      optional

      input :patient_ids,
            title: 'Patient IDs',
            description: 'Comma separated list of patient IDs that in sum contain all MUST SUPPORT elements',
            default: 'baratz-toni, irvine-ronny-lawrence, italia-sofia, howe-deangelo, hayes-arianne, baby-banks-john, banks-mia-leanne'

      def self.properties
        @properties ||= SearchTestProperties.new(
          resource_type: 'MedicationStatement',
          saves_delayed_references: true,
          search_param_names: ['patient'],
          includes: [{ 'parameter' => 'MedicationStatement:medication', 'target_resource' => 'Medication', 'paths' => ['medicationReference'] }]
        )
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:medication_statement_resources] ||= {}
      end

      run do
        run_include_test
      end
    end
  end
end
