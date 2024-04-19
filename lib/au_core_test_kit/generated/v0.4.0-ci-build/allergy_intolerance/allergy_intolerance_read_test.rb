# frozen_string_literal: true

require_relative '../../../read_test'

module AUCoreTestKit
  module AUCoreV040_CI_BUILD
    class AllergyIntoleranceReadTest < Inferno::Test
      include AUCoreTestKit::ReadTest

      title 'Server returns correct AllergyIntolerance resource from AllergyIntolerance read interaction'
      description 'A server SHALL support the AllergyIntolerance read interaction.'

      id :au_core_v040_ci_build_allergy_intolerance_read_test

      def resource_type
        'AllergyIntolerance'
      end

      def scratch_resources
        scratch[:allergy_intolerance_resources] ||= {}
      end

      run do
        perform_read_test(all_scratch_resources)
      end
    end
  end
end
