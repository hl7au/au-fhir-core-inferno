require_relative 'naming'
require_relative 'special_cases'
require_relative '../helpers'

module AUCoreTestKit
  class Generator
    class MDSummaryGenerator
      class << self
        def generate(ig_metadata, base_output_dir)
          new(ig_metadata, base_output_dir).generate
        end
      end

      attr_accessor :ig_metadata, :base_output_dir

      def initialize(ig_metadata, base_output_dir)
        self.ig_metadata = ig_metadata
        self.base_output_dir = base_output_dir
      end

      def template
        @template ||= File.read(File.join(__dir__, 'templates', 'summary.md.erb'))
      end

      def output
        @output ||= ERB.new(template).result(binding)
      end

      def base_output_file_name
        "summary.md"
      end

      def output_file_name
        File.join(base_output_dir, base_output_file_name)
      end

      def generate
        File.open(output_file_name, 'w') { |f| f.write(output) }
      end

      def resource_position(resource)
        # This hash with resource positions is built on a subjective view and can be changed.
        # Used for sorting resources in the summary list.
        resource_positions = {
          "Patient" => 1,
          "Observation" => 2,
          "MedicationRequest" => 3,
          "Encounter" => 4,
          "Condition" => 5,
          "Procedure" => 6,
          "DiagnosticReport" => 7,
          "Immunization" => 8,
          "AllergyIntolerance" => 9,
          "Medication" => 10,
          "MedicationStatement" => 11,
          "Practitioner" => 12,
          "Organization" => 13,
          "PractitionerRole" => 14,
          "HealthcareService" => 15,
          "Location" => 16,
          "DocumentReference" => 17,
          "ServiceRequest" => 18,
          "Provenance" => 19,
          "RelatedPerson" => 20,
        }

        resource_positions[resource]
      end

      def resource_list
        mapped_groups = ig_metadata.groups.map do |group|
          title = group.title
          resource_type = group.resource
          profile_name = group.profile_name
          profile_url = group.profile_url
          required_searches = group.searches.select { |search| search[:expectation] == 'SHALL' }
          search_param_name_string = required_searches
                                       .map { |search| search[:names].join(' + ') }
                                       .map { |names| "* #{names}" }
                                       .join("\n")
          search_validation_resource_type = "#{resource_type} resources"
          group_description = Helpers.get_group_description_text(title,
                                                                 resource_type,
                                                                 profile_name,
                                                                 group.version,
                                                                 profile_url,
                                                                 required_searches,
                                                                 search_param_name_string,
                                                                 search_validation_resource_type,
                                                                 false)
          {
            'title' => title,
            'resource' => resource_type,
            'profile_url' => profile_url,
            'description' => group_description,
            'interactions' => group.interactions.map do |interaction|
              {
                'code' => interaction[:code],
                'expectation' => interaction[:expectation],
              }
            end,
            'searches' => group.searches.map.with_index do |search, index|
              {
                'names' => search[:names],
                'expectation' => search[:expectation],
                'search_string' => make_search_string(group.resource, search[:names]),
                'position' => index + 1
              }
            end
          }
        end

        mapped_groups.group_by { |group| group['resource'] }.map do |resource, groups|
          combined_interactions = groups.flat_map { |group| group['interactions'] }.uniq
          combined_searches = groups.flat_map { |group| group['searches'] }.uniq

          {
            'resource' => resource,
            'position' => resource_position(resource),
            'interactions' => combined_interactions,
            'searches' => combined_searches,
            'groups' => groups.map do |group|
              {
                'title' => group['title'],
                'profile_url' => group['profile_url'],
                'description' => group['description'],
              }
            end
          }
        end.sort_by { |data| data["position"] }
      end

      def make_search_string(resource_name, search_names)
        search = search_names.map.with_index do |search_name, index|
            prefix = index == 0 ? "?" : "&"
            "#{prefix}#{search_name}={#{search_name}}"
        end
        "/#{resource_name}#{search.join('')}"
      end

    end
  end
end
