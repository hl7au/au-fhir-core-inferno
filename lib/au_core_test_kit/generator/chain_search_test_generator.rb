# frozen_string_literal: true

require_relative 'naming'
require_relative 'special_cases'

module AUCoreTestKit
  class Generator
    class ChainSearchTestGenerator
      class << self
        def generate(ig_metadata, base_output_dir)
          ig_metadata.groups
                     .select { |group| group.searches.present? }
                     .each do |group|
            group.search_definitions.each_key do |search_key|
              current_search_definition = group.search_definitions[search_key]
              next unless current_search_definition.key?(:chain) && current_search_definition[:chain].length.positive?

              current_search_definition[:chain].each do |chain_item|
                new(
                  search_key.to_s,
                  group,
                  group.search_definitions[search_key],
                  base_output_dir,
                  chain_item
                ).generate
              end
            end
          end
        end
      end

      attr_accessor :search_name, :group_metadata, :search_metadata, :base_output_dir, :chain_item

      def initialize(search_name, group_metadata, search_metadata, base_output_dir, chain_item)
        self.search_name = search_name
        self.group_metadata = group_metadata
        self.search_metadata = search_metadata
        self.base_output_dir = base_output_dir
        self.chain_item = chain_item
      end

      def template
        @template ||= File.read(File.join(__dir__, 'templates', 'chain_search.rb.erb'))
      end

      def output
        @output ||= ERB.new(template).result(binding)
      end

      def base_output_file_name
        "#{class_name.underscore}.rb"
      end

      def output_file_directory
        File.join(base_output_dir, profile_identifier)
      end

      def output_file_name
        File.join(output_file_directory, base_output_file_name)
      end

      def profile_identifier
        Naming.snake_case_for_profile(group_metadata)
      end

      def test_id
        "au_core_#{group_metadata.reformatted_version}_#{profile_identifier}_#{search_identifier}_chain_search_test"
      end

      def search_identifier
        search_name.to_s.tr('-', '_')
      end

      def search_title
        search_identifier.camelize
      end

      def class_name
        "#{Naming.upper_camel_case_for_profile(group_metadata)}#{search_title}ChainSearchTest"
      end

      def module_name
        "AUCore#{group_metadata.reformatted_version.upcase}"
      end

      def resource_type
        group_metadata.resource
      end

      def conformance_expectation
        chain_item[:expectation]
      end

      def search_param_names
        ["#{search_name}:#{chain_item[:target]}.#{chain_item[:chain]}"]
      end

      def search_param_names_array
        array_of_strings(search_param_names)
      end

      def search_param_name_string
        search_name
      end

      def search_properties
        {}.tap do |properties|
          properties[:resource_type] = "'#{resource_type}'"
          properties[:search_param_names] = search_param_names_array
          properties[:attr_paths] = attribute_paths
        end
      end

      def attribute_paths
        search_metadata[:paths]
      end

      def optional?
        conformance_expectation != 'SHALL'
      end

      def search_definition(name)
        group_metadata.search_definitions[name.to_sym]
      end

      def array_of_strings(array)
        quoted_strings = array.map { |element| "'#{element}'" }
        "[#{quoted_strings.join(', ')}]"
      end

      def search_test_properties_string
        search_properties
          .map { |key, value| "#{' ' * 8}#{key}: #{value}" }
          .join(",\n")
      end

      def url_version
        case group_metadata.version
        when 'v0.3.0-ballot'
          '0.3.0-ballot'
        end
      end

      def generate
        FileUtils.mkdir_p(output_file_directory)
        File.open(output_file_name, 'w') { |f| f.write(output) }

        group_metadata.add_test(
          id: test_id,
          file_name: base_output_file_name
        )
      end

      def title
        "Server returns valid results for #{resource_type} search by #{search_param_name_string} (chained parameters)"
      end

      def description
        <<~DESCRIPTION.gsub(/\n{3,}/, "\n\n")
          A server #{conformance_expectation} support searching by
          #{search_param_names.first} on the #{resource_type} resource. This test
          will pass if the server returns a success response to the request.

          [AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/#{url_version}/CapabilityStatement-au-core-server.html)
        DESCRIPTION
      end
    end
  end
end
