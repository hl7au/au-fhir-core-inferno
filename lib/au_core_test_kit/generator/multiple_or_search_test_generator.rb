# frozen_string_literal: true

require_relative 'naming'
require_relative 'special_cases'
require_relative '../helpers'

module AUCoreTestKit
  class Generator
    class MultipleOrSearchTestGenerator
      class << self
        def generate(ig_metadata, base_output_dir)
          ig_metadata.groups
                     .select { |group| group.searches.present? }
                     .each do |group|
            group.search_definitions.each_key do |search_key|
              new(search_key.to_s, group, group.search_definitions[search_key], base_output_dir).generate if group.search_definitions[search_key].key?(:multiple_or) && search_key.to_s != 'patient'
            end
          end
        end
      end

      attr_accessor :search_name, :group_metadata, :search_metadata, :base_output_dir

      def initialize(search_name, group_metadata, search_metadata, base_output_dir)
        self.search_name = search_name
        self.group_metadata = group_metadata
        self.search_metadata = search_metadata
        self.base_output_dir = base_output_dir
      end

      def template
        @template ||= File.read(File.join(__dir__, 'templates', 'multiple_or_search.rb.erb'))
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
        "au_core_#{group_metadata.reformatted_version}_#{profile_identifier}_#{search_identifier}_multiple_or_search_test"
      end

      def search_identifier
        search_name.to_s.tr('-', '_')
      end

      def search_title
        search_identifier
      end

      def class_name
        "#{Naming.upper_camel_case_for_profile(group_metadata)}#{search_title.capitalize}MultipleOrSearchTest"
      end

      def module_name
        "AUCore#{group_metadata.reformatted_version.upcase}"
      end

      def resource_type
        group_metadata.resource
      end

      def conformance_expectation
        # NOTE: https://github.com/hl7au/au-fhir-core-inferno/issues/61
        if search_name == 'status' && (resource_type == 'Procedure' || resource_type == 'Observation')
          return 'SHOULD'
        end

        search_metadata[:multiple_or]
      end

      def first_search?
        group_metadata.searches.first == search_metadata
      end

      def fixed_value_search?
        first_search? && search_metadata[:names] != ['patient'] &&
          !group_metadata.delayed? && resource_type != 'Patient'
      end

      def fixed_value_search_param_name
        (search_metadata[:names] - [:patient]).first
      end

      def search_param_name_string
        search_name
      end

      def needs_patient_id?
        true
      end

      def search_param_names
        [search_name]
      end

      def search_param_names_array
        array_of_strings(search_param_names)
      end

      def path_for_value(path)
        path == 'class' ? 'local_class' : path
      end

      def optional?
        conformance_expectation == 'SHOULD' || conformance_expectation == 'MAY'
      end

      def search_definition(name)
        group_metadata.search_definitions[name.to_sym]
      end

      def saves_delayed_references?
        first_search? && group_metadata.delayed_references.present?
      end

      def required_multiple_or_search_params
        @required_multiple_or_search_params ||=
          search_definition(search_name)[:multiple_or] == 'SHALL'
      end

      def optional_multiple_or_search_params
        @optional_multiple_or_search_params ||=
          search_definition(search_name)[:multiple_or] == 'SHOULD'
      end

      def required_multiple_or_search_params_string
        required_multiple_or_search_params
      end

      def optional_multiple_or_search_params_string
        optional_multiple_or_search_params
      end

      def required_comparators_string
        array_of_strings(required_comparators.keys)
      end

      def array_of_strings(array)
        quoted_strings = array.map { |element| "'#{element}'" }
        "[#{quoted_strings.join(', ')}]"
      end

      def test_reference_variants?
        first_search? && search_param_names.include?('patient')
      end

      def test_medication_inclusion?
        %w[MedicationRequest MedicationDispense].include?(resource_type)
      end

      def test_post_search?
        first_search?
      end

      def search_properties
        {}.tap do |properties|
          properties[:first_search] = 'true' if first_search?
          properties[:fixed_value_search] = 'true' if fixed_value_search?
          properties[:resource_type] = "'#{resource_type}'"
          properties[:search_param_names] = search_param_names
          properties[:saves_delayed_references] = 'true' if saves_delayed_references?
          properties[:test_medication_inclusion] = 'true' if test_medication_inclusion?
          properties[:test_reference_variants] = 'true' if test_reference_variants?
          if required_multiple_or_search_params.present?
            properties[:multiple_or_search_params] =
              required_multiple_or_search_params_string
          end
          properties[:optional_multiple_or_search_params] = optional_multiple_or_search_params_string if optional_multiple_or_search_params.present?
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

      def description
        Helpers.multiple_test_description('OR', conformance_expectation, search_param_name_string, resource_type, url_version)
      end
    end
  end
end
