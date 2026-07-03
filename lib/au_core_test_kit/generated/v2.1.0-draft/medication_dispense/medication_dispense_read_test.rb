# frozen_string_literal: true

require 'inferno_suite_generator/test_modules/read_test'

module AUCoreTestKit
  module AUCoreV210_DRAFT
    class MedicationDispenseReadTest < Inferno::Test
      include InfernoSuiteGenerator::ReadTest

      title '(SHALL) Server returns correct MedicationDispense resource from MedicationDispense read interaction'
      description 'A server SHALL support the MedicationDispense read interaction.'

      id :au_core_v210_draft_medication_dispense_read_test

      def self.demodata
        @demodata ||= InfernoSuiteGenerator::Generator::IGDemodata.new(
          YAML.load_file(File.join(File.dirname(__dir__), 'demodata.yml'), aliases: true)
        )
      end

      def resource_type
        'MedicationDispense'
      end

      def scratch_resources
        scratch[:medication_dispense_resources] ||= {}
      end

      run do
        perform_read_test(all_scratch_resources)
      end
    end
  end
end
