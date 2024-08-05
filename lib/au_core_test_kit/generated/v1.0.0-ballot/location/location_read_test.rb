# frozen_string_literal: true

require_relative '../../../read_test'

module AUCoreTestKit
  module AUCoreV100_BALLOT
    class LocationReadTest < Inferno::Test
      include AUCoreTestKit::ReadTest

      title '(SHALL) Server returns correct Location resource from Location read interaction'
      description 'A server SHALL support the Location read interaction.'

      input :location_ids,
            title: 'Location IDs',
            description: 'Comma separated list of location IDs that in sum contain all MUST SUPPORT elements',
            default: 'bobrester-medical-center, au-hospital',
            optional: true

      id :au_core_v100_ballot_location_read_test

      def resource_type
        'Location'
      end

      def scratch_resources
        scratch[:location_resources] ||= {}
      end

      run do
        perform_read_test(scratch.dig(:references, 'Location'))
      end
    end
  end
end
