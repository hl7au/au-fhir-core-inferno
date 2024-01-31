require_relative '../../../read_test'

module USCoreTestKit
  module USCoreV030
    class DocumentReferenceReadTest < Inferno::Test
      include USCoreTestKit::ReadTest

      title 'Server returns correct DocumentReference resource from DocumentReference read interaction'
      description 'A server SHALL support the DocumentReference read interaction.'

      id :us_core_v030_document_reference_read_test

      def resource_type
        'DocumentReference'
      end

      def scratch_resources
        scratch[:document_reference_resources] ||= {}
      end

      run do
        perform_read_test(all_scratch_resources)
      end
    end
  end
end
