# frozen_string_literal: true

require 'json'
require_relative '../../validation_test'
require_relative '../../helpers'

module AUCoreTestKit
  class CustomValidationTest < Inferno::Test
    include AUCoreTestKit::ValidationTest
    id :au_core_custom_validation
    title Helpers.custom_validation_test_title_text
    optional
    input :resource_json,
          title: Helpers.custom_validation_test_input_text,
          optional: true
    description Helpers.custom_validation_test_description_text

    def resource_type
      ''
    end

    run do
      skip_if resource_json.blank?

      ig_version = '0.4.0-preview'
      fhir_resource_hash = JSON.parse(resource_json)
      resource_type = fhir_resource_hash['resourceType']
      fhir_resource_profile = fhir_resource_hash['meta']['profile'].first
      fhir_class = FHIR.const_get(resource_type)
      fhir_resource = fhir_class.new(fhir_resource_hash)

      info Helpers.custom_validation_test_info_resource_type_text(resource_type)
      info Helpers.custom_validation_test_info_profile_text(fhir_resource_profile)
      info Helpers.custom_validation_test_info_ig_text(ig_version)

      perform_validation_test([fhir_resource],
                              fhir_resource_profile,
                              ig_version,
                              skip_if_empty: true)
    end
  end
end
