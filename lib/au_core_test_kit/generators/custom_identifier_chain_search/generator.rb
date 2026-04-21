# frozen_string_literal: true

require 'inferno_suite_generator'
require_relative '../special_cases'

module InfernoSuiteGenerator
  class Generator
    class SpecialIdentifiersChainSearchTestGenerator < InfernoSuiteGenerator::Generator::ChainSearchTestGenerator
      class << self
        def generate(ig_metadata, base_output_dir, _absolute_template_path)
          groups_with_searches(ig_metadata).each do |group|
            generate_for_group(group, ig_metadata, base_output_dir)
          end
        end

        private

        def groups_with_searches(ig_metadata)
          ig_metadata.groups.select { |group| group.searches.present? }
        end

        def generate_for_group(group, ig_metadata, base_output_dir)
          group.search_definitions.each do |search_key, current_search_definition|
            each_patient_chain_item(current_search_definition) do |chain_item|
              generation_context = {
                search_name: search_key.to_s,
                group_metadata: group,
                search_metadata: current_search_definition,
                base_output_dir:,
                chain_item:,
                ig_metadata:
              }
              generate_for_identifiers(generation_context)
            end
          end
        end

        def each_patient_chain_item(search_definition)
          return unless search_definition.key?(:chain) && search_definition[:chain].length.positive?

          search_definition[:chain].each do |chain_item|
            yield chain_item if chain_item[:target] == 'Patient'
          end
        end

        def generate_for_identifiers(generation_context)
          SpecialCases.patient_au_identifiers.each do |target_identifier|
            new(generation_context.merge(target_identifier:)).generate
          end
        end
      end

      attr_accessor :search_name, :group_metadata, :search_metadata, :base_output_dir, :chain_item, :target_identifier, :ig_metadata

      def initialize(options)
        super(
          options[:search_name],
          options[:group_metadata],
          options[:search_metadata],
          options[:base_output_dir],
          options[:chain_item],
          options[:ig_metadata]
        )
        self.target_identifier = options[:target_identifier]
      end

      def test_id
        "au_core_#{group_metadata.reformatted_version}_#{profile_identifier}_#{search_identifier}_#{target_identifier[:display].downcase}_chain_search_test"
      end

      def class_name
        "#{Naming.upper_camel_case_for_profile(group_metadata)}#{search_title}_#{target_identifier[:display]}_ChainSearchTest"
      end

      def search_properties
        {}.tap do |properties|
          properties[:resource_type] = "'#{resource_type}'"
          properties[:search_param_names] = search_param_names_array
          properties[:attr_paths] = attribute_paths
          properties[:target_identifier] = target_identifier
        end
      end

      def title
        "Server returns valid results for #{resource_type} search by #{search_param_name_string} (#{target_identifier[:display]}) (chained parameters)"
      end

      def description
        <<~DESCRIPTION.gsub(/\n{3,}/, "\n\n")
          A server #{conformance_expectation} support searching by
          #{search_param_names.first} (#{target_identifier[:display]}) on the #{resource_type} resource. This test
          will pass if the server returns a success response to the request.

          [AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/#{url_version}/CapabilityStatement-au-core-server.html)
        DESCRIPTION
      end
    end
  end
end
