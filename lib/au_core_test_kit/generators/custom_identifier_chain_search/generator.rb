# frozen_string_literal: true

require 'inferno_suite_generator'
require_relative '../special_cases'

module InfernoSuiteGenerator
  class Generator
    class SpecialIdentifiersChainSearchTestGenerator < InfernoSuiteGenerator::Generator::ChainSearchTestGenerator
      class << self
        def generate(ig_metadata, base_output_dir, _absolute_template_path)
          ig_metadata.groups
                     .select { |group| group.searches.present? }
                     .each do |group|
            group.search_definitions.each_key do |search_key|
              current_search_definition = group.search_definitions[search_key]
              next unless current_search_definition.key?(:chain) && current_search_definition[:chain].length.positive?

              current_search_definition[:chain].each do |chain_item|
                next unless chain_item[:target] == 'Patient'

                SpecialCases.patient_au_identifiers.each do |target_identifier|
                  new(
                    search_key.to_s,
                    group,
                    group.search_definitions[search_key],
                    base_output_dir,
                    chain_item,
                    target_identifier,
                    ig_metadata
                  ).generate
                end
              end
            end
          end
        end
      end

      attr_accessor :search_name, :group_metadata, :search_metadata, :base_output_dir, :chain_item, :target_identifier, :ig_metadata

      def initialize(search_name, group_metadata, search_metadata, base_output_dir, chain_item, target_identifier, ig_metadata)
        super(search_name, group_metadata, search_metadata, base_output_dir, chain_item, ig_metadata)
        self.target_identifier = target_identifier
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
