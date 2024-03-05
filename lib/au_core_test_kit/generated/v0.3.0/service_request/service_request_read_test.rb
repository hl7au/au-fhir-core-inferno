require_relative '../../../read_test'

module AUCoreTestKit
  module AUCoreV030
    class ServiceRequestReadTest < Inferno::Test
      include AUCoreTestKit::ReadTest

      title 'Server returns correct ServiceRequest resource from ServiceRequest read interaction'
      description 'A server SHALL support the ServiceRequest read interaction.'

      id :au_core_v030_service_request_read_test

      def resource_type
        'ServiceRequest'
      end

      def scratch_resources
        scratch[:service_request_resources] ||= {}
      end

      run do
        perform_read_test(all_scratch_resources)
      end
    end
  end
end
