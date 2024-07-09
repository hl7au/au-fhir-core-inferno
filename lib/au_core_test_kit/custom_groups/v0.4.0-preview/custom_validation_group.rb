# frozen_string_literal: true

require_relative './custom_validation_test'
require_relative '../../helpers'

module AUCoreTestKit
  module AUCoreV040_BALLOT
    class CustomValidationGroup < Inferno::TestGroup
      id :au_core_v040_custom_validation_group
      title Helpers.custom_validation_group_title_text
      description Helpers.custom_validation_group_description_text
      optional
      run_as_group

      test from: :au_core_custom_validation
    end
  end
end
