require_relative '../../../read_test'

module AUCoreTestKit
  module AUCoreV040_CI_BUILD
    class MedicationRequestReadTest < Inferno::Test
      include AUCoreTestKit::ReadTest

      title 'Server returns correct MedicationRequest resource from MedicationRequest read interaction'
      description 'A server SHALL support the MedicationRequest read interaction.'

      id :au_core_v040_ci_build_medication_request_read_test

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
