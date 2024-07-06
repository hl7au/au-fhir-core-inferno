# frozen_string_literal: true

require_relative './custom_validation_test'

module AUCoreTestKit
  module AUCoreV040_BALLOT
    class CustomValidationGroup < Inferno::TestGroup
      id :au_core_v040_custom_validation_group
      title 'Custom Validation Group'
      description %(
        This test group is designed to validate the conformity of FHIR resources against specified profiles.
        Leveraging the dynamic capabilities of FHIR, this validation ensures that the resources adhere to the standards and guidelines established within the relevant AU Core.
      )
      optional
      run_as_group

      test from: :au_core_custom_validation
    end
  end
end
