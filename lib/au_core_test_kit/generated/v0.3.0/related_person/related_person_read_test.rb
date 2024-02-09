require_relative '../../../read_test'

module AUCoreTestKit
  module AUCoreV030
    class RelatedPersonReadTest < Inferno::Test
      include AUCoreTestKit::ReadTest

      title 'Server returns correct RelatedPerson resource from RelatedPerson read interaction'
      description 'A server SHALL support the RelatedPerson read interaction.'

      id :au_core_v030_related_person_read_test

      def resource_type
        'RelatedPerson'
      end

      def scratch_resources
        scratch[:related_person_resources] ||= {}
      end

      run do
        perform_read_test(all_scratch_resources)
      end
    end
  end
end
