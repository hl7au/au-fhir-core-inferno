require_relative '../../../read_test'

module AUCoreTestKit
  module AUCoreV030
    class WaistcircumReadTest < Inferno::Test
      include AUCoreTestKit::ReadTest

      title 'Server returns correct Observation resource from Observation read interaction'
      description 'A server SHALL support the Observation read interaction.'

      id :au_core_v030_waistcircum_read_test

      def resource_type
        'Observation'
      end

      def scratch_resources
        scratch[:waistcircum_resources] ||= {}
      end

      run do
        perform_read_test(all_scratch_resources)
      end
    end
  end
end
