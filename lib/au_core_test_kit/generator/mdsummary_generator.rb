require_relative 'naming'
require_relative 'special_cases'

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
        puts "template"
        @template ||= File.read(File.join(__dir__, 'templates', 'summary.md.erb'))
      end

      def output
        puts "output"
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
        result = ig_metadata.groups.map.with_index { |group, group_index|
            {
                'resource' => group.resource,
                'position' => group_index + 1,
                'profile_url' => group.profile_url,
                'description' => group.short_description,
                'interactions' => group.interactions.map { |interaction| {
                    'code' => interaction[:code],
                    'expectation' => interaction[:expectation],
                }},
                'searches' => group.searches.map.with_index {|search, search_index| {
                    'names' => search[:names],
                    'expectation' => search[:expectation],
                    'search_string' => make_search_string(group.resource, search[:names]),
                    'position' => search_index + 1
                }}
            }
        }
        result
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
