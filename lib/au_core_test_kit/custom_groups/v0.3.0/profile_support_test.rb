module USCoreTestKit
  module USCoreV311
    class ProfileSupportTest < Inferno::Test
      id :us_core_profile_support
      title 'Capability Statement lists support for required US Core Resoruce Types'
      description %(
        The US Core Implementation Guide states:

        ```
        The US Core Server SHALL:
        1. Support the US Core Patient resource.
        2. Support at least one additional US Core resources.

        In order to support USCDI, servers must support all USCDI resources.
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
            end.uniq

        assert supported_resources.include?('Patient'), 'US Core Patient profile not supported'

        us_core_resources = config.options[:us_core_resources]

        other_resources = us_core_resources.reject { |resource_type| resource_type == 'Patient' }
        other_resources_supported = other_resources.any? { |resource| supported_resources.include? resource }
        assert other_resources_supported, 'No US Core resources other than Patient are supported'

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
