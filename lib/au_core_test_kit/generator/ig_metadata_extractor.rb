require_relative 'ig_metadata'
require_relative 'group_metadata_extractor'

module AUCoreTestKit
  class Generator
    class IGMetadataExtractor
      attr_accessor :ig_resources, :metadata

      def initialize(ig_resources)
        self.ig_resources = ig_resources
        add_missing_supported_profiles
        remove_extra_supported_profiles
        self.metadata = IGMetadata.new
      end

      def extract
        add_metadata_from_ig
        add_metadata_from_resources
        metadata
      end

      def add_metadata_from_ig
        metadata.ig_version = "v#{ig_resources.ig.version}"
      end

      def resources_in_capability_statement
        ig_resources.capability_statement.rest.first.resource
      end

      def add_missing_supported_profiles
        case ig_resources.ig.version
        when '3.1.1'
          # The AU Core v3.1.1 Server Capability Statement does not list support for the
          # required vital signs profiles, so they need to be added
          ig_resources.capability_statement.rest.first.resource
            .find { |resource| resource.type == 'Observation' }
            .supportedProfile.concat [
              'http://hl7.org/fhir/StructureDefinition/bodyheight',
              'http://hl7.org/fhir/StructureDefinition/bodytemp',
              'http://hl7.org/fhir/StructureDefinition/bp',
              'http://hl7.org/fhir/StructureDefinition/bodyweight',
              'http://hl7.org/fhir/StructureDefinition/heartrate',
              'http://hl7.org/fhir/StructureDefinition/resprate'
            ]
        when '5.0.1'
          # The AU Core v5.0.1 Server Capability Statement does not have supported-profile for Encounter
          ig_resources.capability_statement.rest.first.resource
            .find { |resource| resource.type == 'Encounter' }
            .supportedProfile.concat [
              'http://hl7.org/fhir/us/core/StructureDefinition/us-core-encounter'
            ]
        end
      end

      def remove_extra_supported_profiles
        ig_resources.capability_statement.rest.first.resource
            .find { |resource| resource.type == 'Observation' }
            .supportedProfile.delete_if do |profile_url|
              SpecialCases::PROFILES_TO_EXCLUDE.include?(profile_url)
            end
      end

      def add_metadata_from_resources
        profile_arr_to_skip = [
          'http://hl7.org/fhir/uv/sdc/StructureDefinition/sdc-questionnaire',
          "http://hl7.org.au/fhir/core/StructureDefinition/au-core-norelevantfinding",
        ]

        supported_profile_groups = resources_in_capability_statement.flat_map do |resource|
          resource.supportedProfile&.map do |supported_profile|
            supported_profile = supported_profile.split('|').first
            next if profile_arr_to_skip.include?(supported_profile)
            GroupMetadataExtractor.new(resource, supported_profile, metadata, ig_resources).group_metadata
          end
        end.compact

        profile_groups = resources_in_capability_statement.flat_map do |resource|
          GroupMetadataExtractor.new(resource, resource.profile, metadata, ig_resources).group_metadata
        end.compact

        metadata.groups = supported_profile_groups + profile_groups

        metadata.postprocess_groups(ig_resources)
      end
    end
  end
end
