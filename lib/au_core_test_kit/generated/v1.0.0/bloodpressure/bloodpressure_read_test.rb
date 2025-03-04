# frozen_string_literal: true

require 'inferno_suite_generator/read_test'

module AUCoreTestKit
  module AUCoreV100
    class BloodpressureReadTest < Inferno::Test
      include InfernoSuiteGenerator::ReadTest

      title '(SHALL) Server returns correct Observation resource from Observation read interaction'
      description 'A server SHALL support the Observation read interaction.'

      id :au_core_v100_bloodpressure_read_test

      def resource_type
        'Observation'
      end

      def scratch_resources
        scratch[:bloodpressure_resources] ||= {}
      end

      run do
        perform_read_test(all_scratch_resources)
      end
    end
  end
end
