# frozen_string_literal: true

require_relative '../../../read_test'

module AUCoreTestKit
  module AUCoreV040_PREVIEW
    class ConditionReadTest < Inferno::Test
      include AUCoreTestKit::ReadTest

      title '(SHALL) Server returns correct Condition resource from Condition read interaction'
      description 'A server SHALL support the Condition read interaction.'

      id :au_core_v040_preview_condition_read_test

      def resource_type
        'Condition'
      end

      def scratch_resources
        scratch[:condition_resources] ||= {}
      end

      run do
        perform_read_test(all_scratch_resources)
      end
    end
  end
end
