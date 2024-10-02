# frozen_string_literal: true

require_relative 'naming'
require_relative 'special_cases'

module AUCoreTestKit
  class Generator
    class SearchTestGenerator
      class << self
        def generate(ig_metadata, base_output_dir)
          ig_metadata.groups
                     .reject { |group| SpecialCases.exclude_group? group }
                     .select { |group| group.searches.present? }
                     .each do |group|
            group.searches.each { |search| new(group, search, base_output_dir).generate }
          end
        end
      end

      attr_accessor :group_metadata, :search_metadata, :base_output_dir

      def initialize(group_metadata, search_metadata, base_output_dir)
        self.group_metadata = group_metadata
        self.search_metadata = search_metadata
        self.base_output_dir = base_output_dir
      end

      def template
        @template ||= File.read(File.join(__dir__, 'templates', 'search.rb.erb'))
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
        search_metadata[:names].join('_').tr('-', '_')
      end

      def search_title
        search_identifier.camelize
      end

      def class_name
        "#{Naming.upper_camel_case_for_profile(group_metadata)}#{search_title}SearchTest"
      end

      def module_name
        "AUCore#{group_metadata.reformatted_version.upcase}"
      end

      def resource_type
        group_metadata.resource
      end

      def conformance_expectation
        search_metadata[:expectation]
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

      def search_param_name_string
        search_metadata[:names].join(' + ')
      end

      def needs_patient_id?
        search_metadata[:names].include?('patient') ||
          (resource_type == 'Patient' && search_metadata[:names].include?('_id'))
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
        # NOTE: Original behavior changed because we need a clear
        # expectation of the search parameters in tests. If in the
        # CapabilityStatement resource we have SHALL it should be
        # required in the tests.
        # https://github.com/hl7au/au-fhir-core-inferno/issues/47
        # conformance_expectation != 'SHALL' || !search_metadata[:must_support_or_mandatory]
        conformance_expectation != 'SHALL'
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

      def required_multiple_or_search_params
        @required_multiple_or_search_params ||=
          search_param_names.select do |name|
            search_definition(name)[:multiple_or] == 'SHALL'
          end
      end

      def optional_multiple_or_search_params
        @optional_multiple_or_search_params ||=
          search_param_names.select do |name|
            search_definition(name)[:multiple_or] == 'SHOULD'
          end
      end

      def required_multiple_or_search_params_string
        array_of_strings(required_multiple_or_search_params)
      end

      def optional_multiple_or_search_params_string
        array_of_strings(optional_multiple_or_search_params)
      end

      def optional_multiple_and_search_params
        @optional_multiple_and_search_params ||=
          search_param_names.select do |name|
            search_definition(name)[:multiple_and] == 'SHOULD'
          end
      end

      def required_multiple_and_search_params
        @required_multiple_and_search_params ||=
          search_param_names.select do |name|
            search_definition(name)[:multiple_and] == 'SHALL'
          end
      end

      def optional_multiple_and_search_params_string
        array_of_strings(optional_multiple_and_search_params)
      end

      def required_multiple_and_search_params_string
        array_of_strings(required_multiple_and_search_params)
      end

      def required_comparators_string
        array_of_strings(required_comparators.keys)
      end

      def array_of_strings(array)
        quoted_strings = array.map { |element| "'#{element}'" }
        "[#{quoted_strings.join(', ')}]"
      end

      def test_reference_variants?
        return true if resource_type == 'PractitionerRole' && search_param_names.include?('practitioner')

        first_search? && search_param_names.include?('patient')
      end

      def test_medication_inclusion?
        %w[MedicationRequest MedicationDispense].include?(resource_type)
      end

      def test_post_search?
        first_search?
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
          properties[:first_search] = 'true' if first_search?
          properties[:fixed_value_search] = 'true' if fixed_value_search?
          properties[:resource_type] = "'#{resource_type}'"
          properties[:search_param_names] = search_param_names_array
          properties[:saves_delayed_references] = 'true' if saves_delayed_references?
          properties[:possible_status_search] = 'true' if possible_status_search?
          properties[:test_medication_inclusion] = 'true' if test_medication_inclusion?
          properties[:includes] = includes if group_metadata.include_params.present?
          properties[:token_search_params] = token_search_params_string if token_search_params.present?
          properties[:test_reference_variants] = 'true' if test_reference_variants?
          properties[:params_with_comparators] = required_comparators_string if required_comparators.present?
          properties[:test_post_search] = 'true' if first_search?
          properties[:first_search_for_patient_by_patient_id] = 'true' if first_search_for_patient_by_patient_id
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

      def reference_search_description
        return '' unless test_reference_variants?

        <<~REFERENCE_SEARCH_DESCRIPTION
          This test verifies that the server supports searching by reference using
          the form `#{search_param_names.first}=[id]` as well as `#{search_param_names.first}=#{search_param_names.first.capitalize}/[id]`. The two
          different forms are expected to return the same number of results. AU
          Core requires that both forms are supported by AU Core responders.
        REFERENCE_SEARCH_DESCRIPTION
      end

      def first_search_description
        return '' unless first_search?

        <<~FIRST_SEARCH_DESCRIPTION
          Because this is the first search of the sequence, resources in the
          response will be used for subsequent tests.
        FIRST_SEARCH_DESCRIPTION
      end

      def medication_inclusion_description
        return '' unless test_medication_inclusion?

        <<~MEDICATION_INCLUSION_DESCRIPTION
          If any #{resource_type} resources use external references to
          Medications, the search will be repeated with
          `_include=#{resource_type}:medication`.
        MEDICATION_INCLUSION_DESCRIPTION
      end

      def post_search_description
        return '' unless test_post_search?

        <<~POST_SEARCH_DESCRIPTION
          Additionally, this test will check that GET and POST search methods
          return the same number of results. Search by POST is required by the
          FHIR R4 specification, and these tests interpret search by GET as a
          requirement of AU Core #{group_metadata.version}.
        POST_SEARCH_DESCRIPTION
      end

      def description
        <<~DESCRIPTION.gsub(/\n{3,}/, "\n\n")
          A server #{conformance_expectation} support searching by
          #{search_param_name_string} on the #{resource_type} resource. This test
          will pass if resources are returned and match the search criteria. If
          none are returned, the test is skipped.

          #{medication_inclusion_description}
          #{reference_search_description}
          #{first_search_description}
          #{post_search_description}

          [AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/#{url_version}/CapabilityStatement-au-core-server.html)
        DESCRIPTION
      end

      def search_method
        if search_metadata[:names].first == 'identifier' && group_metadata.name == 'au_core_patient'
          'run_search_test_with_system'
        else
          'run_search_test'
        end
      end
    end
  end
end
