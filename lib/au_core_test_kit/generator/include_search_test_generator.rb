# frozen_string_literal: true

require_relative 'naming'
require_relative 'special_cases'

module AUCoreTestKit
  class Generator
    class IncludeSearchTestGenerator
      class << self
        def generate(ig_metadata, base_output_dir)
          ig_metadata.groups
                     .reject { |group| SpecialCases.exclude_group? group }
                     .select { |group| group.include_params.present? }
                     .each do |group|
            group.include_params.each { |include_param| new(group, group.searches.first, base_output_dir, include_param).generate }
          end
        end
      end

      attr_accessor :group_metadata, :search_metadata, :base_output_dir, :include_param

      def initialize(group_metadata, search_metadata, base_output_dir, include_param)
        self.group_metadata = group_metadata
        self.search_metadata = search_metadata
        self.base_output_dir = base_output_dir
        self.include_param = include_param
      end

      def template
        @template ||= File.read(File.join(__dir__, 'templates', 'include.rb.erb'))
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
        "au_core_#{group_metadata.reformatted_version}_#{profile_identifier}_#{search_identifier}_search_test"
      end

      def search_identifier
        # search_metadata[:names].join('_').tr('-', '_')
        # include_param
        includes.first['target_resource']
      end

      def search_title
        search_identifier.camelize
      end

      def class_name
        "#{Naming.upper_camel_case_for_profile(group_metadata)}#{search_title}IncludeTest"
      end

      def module_name
        "AUCore#{group_metadata.reformatted_version.upcase}"
      end

      def resource_type
        group_metadata.resource
      end

      def conformance_expectation
        'SHOULD'
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

      def first_search_for_patient_by_patient_id
        first_search? && resource_type == 'Patient' && search_metadata[:names].first == '_id'
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

      def needs_patient_id?
        true
      end

      def search_param_names
        search_params.map { |param| param[:name] }
      end

      def search_param_names_array
        array_of_strings(search_param_names)
      end

      def path_for_value(path)
        path == 'class' ? 'local_class' : path
      end

      def required_comparators_for_param(name)
        search_definition(name)[:comparators].select { |_comparator, expectation| expectation == 'SHALL' }
      end

      def required_comparators
        @required_comparators ||=
          search_param_names.each_with_object({}) do |name, comparators|
            required_comparators = required_comparators_for_param(name)
            comparators[name] = required_comparators if required_comparators.present?
          end
      end

      def optional?
        true
      end

      def search_definition(name)
        group_metadata.search_definitions[name.to_sym]
      end

      def saves_delayed_references?
        first_search? && group_metadata.delayed_references.present?
      end

      def possible_status_search?
        search_metadata[:names].none? { |name| name.include? 'status' } &&
          group_metadata.search_definitions.keys.any? { |key| key.to_s.include? 'status' }
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

      def test_reference_variants?
        return true if resource_type == 'PractitionerRole' && search_param_names.include?('practitioner')

        first_search? && search_param_names.include?('patient')
      end

      def includes
        # The medication SearchParameter does not exist for the MedicationStatement
        # and MedicationRequest resources in the current version of the IG,
        # we shall keep special cases to provide functionality for the "_include" tests.
        # https://jira.csiro.au/browse/ST-400
        special_cases = {
          'MedicationRequest:medication' => { 'parameter' => 'MedicationRequest:medication', 'target_resource' => 'Medication', 'paths' => ['medicationReference'] },
          'MedicationStatement:medication' => { 'parameter' => 'MedicationStatement:medication', 'target_resource' => 'Medication', 'paths' => ['medicationReference'] }
        }
        include_params_list = group_metadata.include_params
        search_definitions = group_metadata.search_definitions

        include_params_list.map do |include_param|
          if special_cases.key?(include_param)
            puts "Special case for include_param: #{include_param}"

            return [special_cases[include_param]]
          end

          target_resource = ''
          paths = ''
          search_definitions.each_key do |search_def_key|
            current_search_def_path = search_definitions[search_def_key]
            next unless current_search_def_path[:full_paths].first.split('.') == include_param.split(':')

            target_resource = current_search_def_path[:target_resource]
            paths = current_search_def_path[:paths]
            break
          end

          {
            'parameter' => include_param,
            'target_resource' => target_resource,
            'paths' => paths
          }
        end
      end

      def search_properties
        {}.tap do |properties|
          properties[:resource_type] = "'#{resource_type}'"
          properties[:saves_delayed_references] = 'true' if saves_delayed_references?
          properties[:search_param_names] = search_param_names_array
          properties[:includes] = includes if group_metadata.include_params.present?
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

      def target_resources_string
        includes.map { |include| include['target_resource'] }.join(', ')
      end

      def include_params_string
        includes.map { |include| include['parameter'] }.join(', ')
      end

      def search_param_names_string
        search_param_names.join(', ')
      end

      def title
        "Server returns #{target_resources_string} resources from #{resource_type} search by #{search_param_names_string} and #{include_params_string}"
      end

      def description
        <<~DESCRIPTION.gsub(/\n{3,}/, "\n\n")
        This test will perform a search by #{search_param_names_string} and #{include_params_string}
        Test will pass if a #{target_resources_string} resources are found in the response.
        DESCRIPTION
      end

      def search_method
        'run_include_test'
      end
    end
  end
end
