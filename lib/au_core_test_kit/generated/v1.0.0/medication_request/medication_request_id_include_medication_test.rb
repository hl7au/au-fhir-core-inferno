# frozen_string_literal: true

require 'inferno_suite_generator/search_test'
require 'inferno_suite_generator/search_test_properties'
require 'inferno_suite_generator/generator/group_metadata'
require 'inferno_suite_generator/helpers'

module AUCoreTestKit
  module AUCoreV100
    class MedicationRequestIdIncludeMedicationTest < Inferno::Test
      include InfernoSuiteGenerator::SearchTest
      title 'Server returns Medication resources from MedicationRequest search by _id and MedicationRequest:medication'
      description %(
This test will perform a search by _id and the _include=MedicationRequest:medication

Test will pass if a Medication resources are found in the response.

      )

      id :au_core_v100_medication_request__id_include__id_search_test
      optional

      input :patient_ids,
            title: 'Patient IDs',
            description: 'Comma separated list of patient IDs that in sum contain all MUST SUPPORT elements',
            default: 'baratz-toni, irvine-ronny-lawrence, italia-sofia, howe-deangelo, hayes-arianne, baby-banks-john, banks-mia-leanne'

      def self.properties
        @properties ||= InfernoSuiteGenerator::SearchTestProperties.new(
          resource_type: 'MedicationRequest',
          search_param_names: ['_id'],
          includes: [{ 'parameter' => 'MedicationRequest:medication', 'target_resource' => 'Medication', 'paths' => ['medicationReference'] }],
          use_any_data_for_search: true
        )
      end

      def self.metadata
        @metadata ||= InfernoSuiteGenerator::Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
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
