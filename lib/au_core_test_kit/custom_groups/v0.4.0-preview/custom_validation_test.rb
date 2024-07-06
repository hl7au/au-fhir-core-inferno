# frozen_string_literal: true

require 'json'
require_relative '../../validation_test'

module AUCoreTestKit
  class CustomValidationTest < Inferno::Test
    include AUCoreTestKit::ValidationTest
    id :au_core_custom_validation
    title 'Custom validation of the resource'
    optional
    input :resource_json,
          title: 'FHIR resource in JSON format (custom validation)',
          optional: true
    description %(
      This test automatically identifies and validates any provided FHIR resource.
      Users are required to input the FHIR resource in JSON format, referred to as 'resource_json'.
      The test extracts the applicable profile for validation from the first element in the 'meta.profile' array, located at the path: resource.meta.profile.0.
      This profile serves as the benchmark for the validation process.

      Given the optional nature of this test, its results do not influence the final outcome of the test report.
    )

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

      info "Resource type to validate is #{resource_type}"
      info "Resource profile to validate is #{fhir_resource_profile}"
      info "IG version to validate is #{ig_version}"

      perform_validation_test([fhir_resource],
                              fhir_resource_profile,
                              ig_version,
                              skip_if_empty: true)
    end
  end
end
