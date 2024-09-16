# frozen_string_literal: true

require_relative 'assert_helpers'

module AUCoreTestKit
  module ValidationTest
    include AssertHelpers

    DAR_CODE_SYSTEM_URL = 'http://terminology.hl7.org/CodeSystem/data-absent-reason'
    DAR_EXTENSION_URL = 'http://hl7.org/fhir/StructureDefinition/data-absent-reason'

    def perform_validation_test(resources,
                                profile_url,
                                profile_version,
                                skip_if_empty: true)

      conditional_skip_with_msg skip_if_empty && resources.blank?,
                                "No #{resource_type} resources conforming to the #{profile_url} profile were returned"

      omit_if resources.blank?,
              "No #{resource_type} resources provided so the #{profile_url} profile does not apply"

      profile_with_version = "#{profile_url}|#{profile_version}"
      resources.each do |resource|
        resource_is_valid?(resource:, profile_url: profile_with_version)
        check_for_dar(resource)
      end

      errors_found = messages.any? { |message| message[:type] == 'error' }

      assert !errors_found, "Resource does not conform to the profile #{profile_with_version}"
    end

    def check_for_dar(resource)
      unless scratch[:dar_code_found]
        resource.each_element do |element, _meta, _path|
          next unless element.is_a?(FHIR::Coding)

          check_for_dar_code(element)
        end
      end

      return if scratch[:dar_extension_found]

      check_for_dar_extension(resource)
    end

    def check_for_dar_code(coding)
      return unless coding.code == 'unknown' && coding.system == DAR_CODE_SYSTEM_URL

      scratch[:dar_code_found] = true
      output dar_code_found: 'true'
    end

    def check_for_dar_extension(resource)
      return unless resource.source_contents&.include? DAR_EXTENSION_URL

      scratch[:dar_extension_found] = true
      output dar_extension_found: 'true'
    end
  end
end
