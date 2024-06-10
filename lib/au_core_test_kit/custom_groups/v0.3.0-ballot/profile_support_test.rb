# frozen_string_literal: true

module AUCoreTestKit
  module AUCoreV030_BALLOT
    class ProfileSupportTest < Inferno::Test
      id :au_core_profile_support
      title 'Capability Statement lists support for required AU Core Resoruce Types'
      description %(
        The AU Core Implementation Guide states:

        ```
        The AU Core Server SHALL:
        1. Support the AU Core Patient resource.
        2. Support at least one additional AU Core resources.
        ```
      )
      uses_request :capability_statement

      run do
        assert_resource_type(:capability_statement)
        capability_statement = resource

        supported_resources =
          capability_statement.rest
                              &.each_with_object([]) do |rest, resources|
            rest.resource.each { |resource| resources << resource.type }
          end&.uniq

        assert supported_resources.include?('Patient'), 'AU Core Patient profile not supported'

        au_core_resources = config.options[:au_core_resources]

        other_resources = au_core_resources.reject { |resource_type| resource_type == 'Patient' }
        other_resources_supported = other_resources.any? { |resource| supported_resources.include? resource }
        assert other_resources_supported, 'No AU Core resources other than Patient are supported'

        if config.options[:required_resources].present?
          missing_resources = config.options[:required_resources] - supported_resources

          missing_resource_list =
            missing_resources
            .map { |resource| "`#{resource}`" }
            .join(', ')

          assert missing_resources.empty?,
                 "The CapabilityStatement did not list support for the following resources: #{missing_resource_list}"
        end
      end
    end
  end
end
