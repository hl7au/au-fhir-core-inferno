# frozen_string_literal: true

require_relative '../../../read_test'

module AUCoreTestKit
  module AUCoreV040_CI_BUILD
    class LocationReadTest < Inferno::Test
      include AUCoreTestKit::ReadTest

      title 'Server returns correct Location resource from Location read interaction'
      description 'A server SHALL support the Location read interaction.'

      id :au_core_v040_ci_build_location_read_test

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
