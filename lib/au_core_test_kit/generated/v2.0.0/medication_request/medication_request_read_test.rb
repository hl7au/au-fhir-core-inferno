# frozen_string_literal: true

require 'inferno_suite_generator/test_modules/read_test'

module AUCoreTestKit
  module AUCoreV200
    class MedicationRequestReadTest < Inferno::Test
      include InfernoSuiteGenerator::ReadTest

      title '(SHALL) Server returns correct MedicationRequest resource from MedicationRequest read interaction'
      description 'A server SHALL support the MedicationRequest read interaction.'

      id :au_core_v200_medication_request_read_test

      def self.demodata
        @demodata ||= InfernoSuiteGenerator::Generator::IGDemodata.new(
          YAML.load_file(File.join(File.dirname(__dir__), 'demodata.yml'), aliases: true)
        )
      end

      def resource_type
        'MedicationRequest'
      end

      def scratch_resources
        scratch[:medication_request_resources] ||= {}
      end

      run do
        perform_read_test(all_scratch_resources)
      end
    end
  end
end
