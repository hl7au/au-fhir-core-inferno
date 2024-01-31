require_relative '../../../read_test'

module USCoreTestKit
  module USCoreV030
    class EncounterReadTest < Inferno::Test
      include USCoreTestKit::ReadTest

      title 'Server returns correct Encounter resource from Encounter read interaction'
      description 'A server SHALL support the Encounter read interaction.'

      id :us_core_v030_encounter_read_test

      def resource_type
        'Encounter'
      end

      def scratch_resources
        scratch[:encounter_resources] ||= {}
      end

      run do
        perform_read_test(all_scratch_resources)
      end
    end
  end
end
