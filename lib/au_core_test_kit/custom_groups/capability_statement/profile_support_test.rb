# frozen_string_literal: true

module AUCoreTestKit
  class ProfileSupportTest < Inferno::Test
    id :au_core_profile_support
    title 'Capability Statement lists support for required AU Core Profiles'
    description %(
      The AU Core Implementation Guide states:

      ```
      The AU Core Server SHALL:
      1. Support the AU Core Patient resource profile.
      2. Support at least one additional resource profile from the list of US
         Core Profiles.
      ```
    )
    uses_request :capability_statement

    run do
      assert_resource_type(:capability_statement)
      capability_statement = resource

      supported_profiles =
        capability_statement.rest
                            &.each_with_object([]) do |rest, profiles|
          rest.resource.each { |resource| profiles.concat(resource.supportedProfile) }
        end&.uniq

      assert supported_profiles.include?('http://hl7.org.au/fhir/core/0.3.0-ballot/StructureDefinition-au-core-patient.html'),
             'AU Core Patient profile not supported'

      au_core_profiles = config.options[:au_core_profiles]

      other_profiles = au_core_profiles.reject { |resource_type| resource_type == 'http://hl7.org.au/fhir/core/0.3.0-ballot/StructureDefinition-au-core-patient.html' }
      other_profiles_supported = other_profiles.any? { |profile| supported_profiles.include? profile }
      assert other_profiles_supported, 'No AU Core profiles other than Patient are supported'

      if config.options[:required_profiles].present?
        required_profiles = config.options[:required_profiles]

        missing_profiles = required_profiles - supported_profiles

        missing_profiles_list =
          missing_profiles
          .map { |resource| "`#{resource}`" }
          .join(', ')

        assert missing_profiles.empty?,
               "The CapabilityStatement did not list support for the following resources: #{missing_profiles_list}"
      end
    end
  end
end
