require_relative '../../../read_test'

module AUCoreTestKit
  module AUCoreV030
    class PractitionerReadTest < Inferno::Test
      include AUCoreTestKit::ReadTest

      title 'Server returns correct Practitioner resource from Practitioner read interaction'
      description 'A server SHALL support the Practitioner read interaction.'

      id :au_core_v030_practitioner_read_test

      def resource_type
        'Practitioner'
      end

      def scratch_resources
        scratch[:practitioner_resources] ||= {}
      end

      run do
        perform_read_test(scratch.dig(:references, 'Practitioner'))
      end
    end
  end
end
