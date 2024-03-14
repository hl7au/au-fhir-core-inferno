require_relative 'naming'
require_relative 'special_cases'
require_relative '../helpers'

# Resources that we don't need to show in the summary exhibit behavior similar to that of the generated test groups.
EXCLUDED_RESOURCES = %w[Location Medication PractitionerRole]

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

      def prepare_interactions(interactions)
        interactions.map do |interaction|
          {
            'code' => interaction[:code],
            'expectation' => interaction[:expectation],
          }
        end
      end

      def prepare_searches(searches, resource_name)
        searches.map.with_index do |search, index|
          {
            'names' => search[:names],
            'expectation' => search[:expectation],
            'search_string' => make_search_string(resource_name, search[:names]),
            'position' => index + 1
          }
        end
      end

      def prepare_group_description(group)
        required_searches = group.searches.select { |search| search[:expectation] == 'SHALL' }
        search_param_name_string = required_searches
                                     .map { |search| search[:names].join(' + ') }
                                     .map { |names| "* #{names}" }
                                     .join("\n")
        Helpers.get_group_description_text(group.title,
                                           group.resource,
                                           group.profile_name,
                                           group.version,
                                           group.profile_url,
                                           required_searches,
                                           search_param_name_string,
                                           "#{group.resource} resources",
                                           false)
      end

      def map_group(group)
        {
          'title' => group.title,
          'resource' => group.resource,
          'profile_url' => group.profile_url,
          'description' => prepare_group_description(group),
          'interactions' => prepare_interactions(group.interactions),
          'searches' => prepare_searches(group.searches, group.resource)
        }
      end

      def capability_statement_group
        {
          'title' => "CapabilityStatement",
          'resource' => "CapabilityStatement",
          'profile_url' => "CapabilityStatement",
          'description' => Helpers.get_capability_statement_group_description_text('Capability Statement', false),
          'interactions' => [],
          'searches' => []
        }
      end

      def resource_list
        filtered_profile_groups = ig_metadata.ordered_groups.reject { |group| EXCLUDED_RESOURCES.include? group.resource }
        all_profiles_groups = [capability_statement_group] + filtered_profile_groups.map { |group| map_group(group) }
        all_profiles_groups.map.with_index(1) {|hash, index| hash.merge({"position" => index}) }
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
