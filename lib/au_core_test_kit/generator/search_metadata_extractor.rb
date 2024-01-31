require_relative 'search_definition_metadata_extractor'

module USCoreTestKit
  class Generator
    class SearchMetadataExtractor
      COMBO_EXTENSION_URL =
        'http://hl7.org/fhir/StructureDefinition/capabilitystatement-search-parameter-combination'.freeze

      attr_accessor :resource_capabilities, :ig_resources, :profile_elements, :group_metadata

      def initialize(resource_capabilities, ig_resources, profile_elements, group_metadata)
        self.resource_capabilities = resource_capabilities
        self.ig_resources = ig_resources
        self.profile_elements = profile_elements
        self.group_metadata = group_metadata
      end

      def searches
        @searches ||= basic_searches + combo_searches
      end

      def conformance_expectation(search_param)
        search_param.extension.first.valueCode # TODO: fix expectation extension finding
      end

      def no_search_params?
        resource_capabilities.searchParam.blank?
      end

      def basic_searches
        return [] if no_search_params?

        resource_capabilities.searchParam
          .select { |search_param| ['SHALL', 'SHOULD'].include? conformance_expectation(search_param) }
          .map do |search_param|
            {
              names: [search_param.name],
              expectation: conformance_expectation(search_param)
            }
          end
      end

      def search_extensions
        resource_capabilities.extension
      end

      def combo_searches
        return [] if search_extensions.blank?

        search_extensions
          .select { |extension| extension.url == COMBO_EXTENSION_URL }
          .select { |extension| ['SHALL', 'SHOULD'].include? conformance_expectation(extension) }
          .map do |extension|
            names = extension.extension.select { |param| param.valueString.present? }.map(&:valueString)
            {
              expectation: conformance_expectation(extension),
              names: names
            }
          end
      end

      def search_param_names
        searches.flat_map { |search| search[:names] }.uniq
      end

      def search_definitions
        search_param_names.each_with_object({}) do |name, definitions|
          definitions[name.to_sym] =
            SearchDefinitionMetadataExtractor.new(name, ig_resources, profile_elements, group_metadata).search_definition
        end
      end
    end
  end
end
