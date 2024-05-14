# frozen_string_literal: true

require_relative 'naming'
require_relative 'special_cases'

module AUCoreTestKit
  class Generator
    class SpecialIdentifierSearchTestGenerator
      class << self
        def generate(ig_metadata, base_output_dir)
          ig_metadata.groups.reject { |group| SpecialCases.exclude_group? group }
            .select { |group| group.name == 'au_core_patient' }
            .select { |group| group.searches.present? }
            .each do |group|
              group.searches.each do |search|
                next unless search[:names].include? 'identifier'

                %w[ihi medicare dva].each do |special_identifier|
                  new(group, search, base_output_dir, special_identifier).generate
                end
              end
          end
        end
      end

      attr_accessor :group_metadata, :search_metadata, :base_output_dir, :special_identifier

      def initialize(group_metadata, search_metadata, base_output_dir, special_identifier)
        self.group_metadata = group_metadata
        self.search_metadata = search_metadata
        self.base_output_dir = base_output_dir
        self.special_identifier = special_identifier
      end

      def template
        @template ||= File.read(File.join(__dir__, 'templates', 'special_identifier_search.rb.erb'))
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
        "au_core_#{group_metadata.reformatted_version}_#{profile_identifier}_#{search_identifier}_#{special_identifier}_search_test"
      end

      def search_identifier
        search_metadata[:names].join('_').tr('-', '_')
      end

      def search_title
        search_identifier.camelize
      end

      def class_name
        "#{Naming.upper_camel_case_for_profile(group_metadata)}#{search_title}_#{special_identifier}SearchTest"
      end

      def module_name
        "AUCore#{group_metadata.reformatted_version.upcase}"
      end

      def resource_type
        group_metadata.resource
      end

      def search_params
        @search_params ||=
          search_metadata[:names].map do |name|
            {
              name:,
              path: search_definition(name)[:path]
            }
          end
      end

      def search_param_name_string
        search_metadata[:names].join(' + ')
      end

      def search_param_names
        search_params.map { |param| param[:name] }
      end

      def search_param_names_array
        array_of_strings(search_param_names)
      end

      def optional?
        true
      end

      def search_definition(name)
        group_metadata.search_definitions[name.to_sym]
      end

      def token_search_params
        @token_search_params ||=
          search_param_names.select do |name|
            %w[Identifier CodeableConcept Coding].include? group_metadata.search_definitions[name.to_sym][:type]
          end
      end

      def token_search_params_string
        array_of_strings(token_search_params)
      end

      def array_of_strings(array)
        quoted_strings = array.map { |element| "'#{element}'" }
        "[#{quoted_strings.join(', ')}]"
      end

      def search_properties
        {}.tap do |properties|
          properties[:resource_type] = "'#{resource_type}'"
          properties[:search_param_names] = search_param_names_array
          properties[:token_search_params] = token_search_params_string if token_search_params.present?
          properties[:identifier_type] = "'#{special_identifier}'"
        end
      end

      def url_version
        case group_metadata.version
        when 'v0.3.0-ballot'
          '0.3.0-ballot'
        end
      end

      def search_test_properties_string
        search_properties
          .map { |key, value| "#{' ' * 8}#{key}: #{value}" }
          .join(",\n")
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
        identifier_name_hash = {
          'dva' => 'DVA',
          'medicare' => 'Medicare',
          'ihi' => 'IHI'
        }

        identifier_name = identifier_name_hash[special_identifier]

        "Server returns valid results for Patient search by identifier (#{identifier_name})"
      end

      def description
        <<~DESCRIPTION.gsub(/\n{3,}/, "\n\n")
          A server SHOULD support searching by
          #{search_param_name_string} (#{special_identifier}) on the #{resource_type} resource. This test
          will pass if resources are returned and match the search criteria. If
          none are returned, the test is skipped.

          [AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/#{url_version}/CapabilityStatement-au-core-server.html)
        DESCRIPTION
      end
    end
  end
end
