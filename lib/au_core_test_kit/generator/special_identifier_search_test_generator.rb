# frozen_string_literal: true

require_relative 'naming'
require_relative 'special_cases'
require_relative 'search_test_generator'

module AUCoreTestKit
  class Generator
    class SpecialIdentifierSearchTestGenerator < SearchTestGenerator
      class << self
        def generate(ig_metadata, base_output_dir)
          ig_metadata.groups.reject { |group| SpecialCases.exclude_group? group }
            .select { |group| ['au_core_patient', 'au_core_practitioner', 'au_core_organization', 'au_core_practitionerrole'].include? group.name }
            .select { |group| group.searches.present? }
            .each do |group|
              group.searches.each do |search|
                next unless search[:names].include? 'identifier'
                identifier_arr =
                  case group.name
                  when 'au_core_patient'
                    SpecialCases.patient_au_identifiers
                  when 'au_core_practitioner'
                    SpecialCases.practitioner_au_identifiers
                  when 'au_core_practitionerrole'
                    SpecialCases.practitionerrole_au_identifiers
                  when 'au_core_organization'
                    SpecialCases.organization_au_identifiers
                  end
                identifier_arr.each do |special_identifier|
                  new(group, search, base_output_dir, special_identifier).generate
                end
              end
          end
        end
      end

      attr_accessor :group_metadata, :search_metadata, :base_output_dir, :special_identifier

      def initialize(group_metadata, search_metadata, base_output_dir, special_identifier)
        super(group_metadata, search_metadata, base_output_dir)
        self.special_identifier = special_identifier
      end

      def template
        @template ||= File.read(File.join(__dir__, 'templates', 'special_identifier_search.rb.erb'))
      end

      def test_id
        "au_core_#{group_metadata.reformatted_version}_#{profile_identifier}_#{search_identifier}_#{special_identifier[:display].delete('-').downcase}_search_test"
      end

      def class_name
        "#{Naming.upper_camel_case_for_profile(group_metadata)}#{search_title}#{special_identifier[:display].delete('-')}SearchTest"
      end

      def optional?
        true
      end

      def search_properties
        {}.tap do |properties|
          properties[:resource_type] = "'#{resource_type}'"
          properties[:search_param_names] = search_param_names_array
          properties[:token_search_params] = token_search_params_string if token_search_params.present?
          properties[:target_identifier] = special_identifier
        end
      end

      def title
        "Server returns valid results for #{resource_type} search by identifier (#{special_identifier[:display]})"
      end

      def description
        <<~DESCRIPTION.gsub(/\n{3,}/, "\n\n")
          A server SHOULD support searching by
          #{search_param_name_string} (#{special_identifier[:display]}) on the #{resource_type} resource. This test
          will pass if resources are returned and match the search criteria. If
          none are returned, the test is skipped.

          [AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/#{url_version}/CapabilityStatement-au-core-server.html)
        DESCRIPTION
      end
    end
  end
end
