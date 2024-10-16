# frozen_string_literal: true

require_relative 'naming'
require_relative 'special_cases'
require_relative 'search_test_generator'

module AUCoreTestKit
  class Generator
    class IncludeSearchTestGenerator < SearchTestGenerator
      class << self
        def generate(ig_metadata, base_output_dir)
          ig_metadata.groups
                     .reject { |group| SpecialCases.exclude_group? group }
                     .select { |group| group.include_params.present? }
                     .each do |group|
            group.searches.each do |search|
              next unless SpecialCases.search_params_for_include_by_resource[group.resource].include? search[:names]

              group.include_params.each do |include_param|
                new(group, search, base_output_dir, include_param).generate
              end
            end
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

      def search_identifier
        search_metadata[:names].join('_').tr('-', '_')
      end

      def test_id
        "au_core_#{group_metadata.reformatted_version}_#{profile_identifier}_#{search_param_names_lodash_string}_include_#{search_identifier.downcase}_search_test"
      end

      def search_title
        search_identifier.camelize
      end

      def class_name
        "#{Naming.upper_camel_case_for_profile(group_metadata)}#{search_title}Include#{includes.first['target_resource']}Test"
      end

      def conformance_expectation
        'SHOULD'
      end

      def optional?
        true
      end

      def needs_patient_id?
        true
      end

      def search_properties
        {}.tap do |properties|
          properties[:resource_type] = "'#{resource_type}'"
          properties[:saves_delayed_references] = 'true' if saves_delayed_references?
          properties[:search_param_names] = search_param_names_array
          properties[:includes] = includes if group_metadata.include_params.present?
          properties[:use_any_data_for_search] = true
        end
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

      def search_param_names_lodash_string
        search_param_names.join('_')
      end

      def title
        "Server returns #{target_resources_string} resources from #{resource_type} search by #{search_param_names_string} and #{include_params_string}"
      end

      def description
        <<~DESCRIPTION.gsub(/\n{3,}/, "\n\n")
          This test will perform a search by #{search_param_names_string} and the _include=#{include_params_string}

          Test will pass if a #{target_resources_string} resources are found in the response.
        DESCRIPTION
      end

      def search_method
        'run_include_test'
      end
    end
  end
end
