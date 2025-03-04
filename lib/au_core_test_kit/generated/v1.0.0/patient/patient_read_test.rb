# frozen_string_literal: true

require 'inferno_suite_generator/read_test'

module AUCoreTestKit
  module AUCoreV100
    class PatientReadTest < Inferno::Test
      include InfernoSuiteGenerator::ReadTest

      title '(SHALL) Server returns correct Patient resource from Patient read interaction'
      description 'A server SHALL support the Patient read interaction.'

      id :au_core_v100_patient_read_test

      def resource_type
        'Patient'
      end

      def scratch_resources
        scratch[:patient_resources] ||= {}
      end

      run do
        perform_read_test(all_scratch_resources)
      end
    end
  end
end
