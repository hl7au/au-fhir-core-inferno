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

      def resource_list
        groups = ig_metadata.ordered_groups.reject { |group| ["Location", "Medication", "PractitionerRole"].include? group.resource }
        mapped_groups = groups.map.with_index do |group, index|
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
            'position' => index + 2,
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
        mapped_groups.unshift(
          {
            'title' => "CapabilityStatement",
            'resource' => "CapabilityStatement",
            'position' => 1,
            'profile_url' => "CapabilityStatement",
            'description' => Helpers.get_capability_statement_group_description_text('Capability Statement', false),
            'interactions' => [],
            'searches' => []
          }
        )
        mapped_groups
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
