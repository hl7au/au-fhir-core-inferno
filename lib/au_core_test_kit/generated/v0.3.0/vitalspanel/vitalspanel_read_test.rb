require_relative '../../../read_test'

module AUCoreTestKit
  module AUCoreV030
    class VitalspanelReadTest < Inferno::Test
      include AUCoreTestKit::ReadTest

      title 'Server returns correct Observation resource from Observation read interaction'
      description 'A server SHALL support the Observation read interaction.'

      id :au_core_v030_vitalspanel_read_test

      def resource_type
        'Observation'
      end

      def scratch_resources
        scratch[:vitalspanel_resources] ||= {}
      end

      run do
        perform_read_test(all_scratch_resources)
      end
    end
  end
end
