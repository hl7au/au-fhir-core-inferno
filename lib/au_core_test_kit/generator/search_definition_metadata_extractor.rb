# frozen_string_literal: true

require_relative 'value_extractor'

module AUCoreTestKit
  class Generator
    class SearchDefinitionMetadataExtractor
      attr_accessor :ig_resources, :name, :profile_elements, :group_metadata

      def initialize(name, ig_resources, profile_elements, group_metadata)
        self.name = name
        self.ig_resources = ig_resources
        self.profile_elements = profile_elements
        self.group_metadata = group_metadata
      end

      def search_definition
        @search_definition ||=
          {
            paths:,
            full_paths:,
            comparators:,
            values:,
            type:,
            contains_multiple: contains_multiple?,
            multiple_or: multiple_or_expectation,
            multiple_and: multiple_and_expectation,
            chain:,
            target_resource:
          }.compact
      end

      def resource
        group_metadata[:resource]
      end

      def param
        @param ||= ig_resources.search_param_by_resource_and_name(resource, name)
      end

      def param_hash
        param.source_hash
      end

      def target_resource
        param.target.first
      end

      def full_paths
        @full_paths ||=
          begin
            full_paths = param.expression.split('|').map do |expr|
              expr.strip.gsub(/.where\(resolve\((.*)/, '').gsub(/url = '/,
                                                                'url=\'').gsub(/\.ofType\(([^)]+)\)/) do |_match|
                type_name = ::Regexp.last_match(1)
                "#{type_name[0].upcase}#{type_name[1..]}"
              end
            end.filter { |path| path.split('.').first == resource }

            full_paths.map do |path|
              path.scan(/[. ]as[( ]([^)]*)[)]?/).flatten.map do |as_type|
                path.gsub!(/[. ]as[( ](#{as_type}[^)]*)[)]?/, as_type.upcase_first) if as_type.present?
              end
            end

            # path = param.expression.gsub(/.where\(resolve\((.*)/, '').gsub(/url = '/, 'url=\'')
            # path = path[1..-2] if path.start_with?('(') && path.end_with?(')')
            # path.scan(/[. ]as[( ]([^)]*)[)]?/).flatten.map do |as_type|
            #   path.gsub!(/[. ]as[( ](#{as_type}[^)]*)[)]?/, as_type.upcase_first) if as_type.present?
            # end

            # full_paths = path.split('|')
            # # There is a problem with whitespaces in paths
            # full_paths = full_paths.map(&:strip)

            # There is a bug in AU Core 5 asserted-date search parameter. See FHIR-40573
            remove_additional_extension_from_asserted_date(full_paths) if param.respond_to?(:version) && param.version == '5.0.1' && name == 'asserted-date'

            full_paths
          end
      end

      def remove_additional_extension_from_asserted_date(full_paths)
        full_paths.each do |full_path|
          next unless full_path.include?('http://hl7.org/fhir/StructureDefinition/condition-assertedDate')

          full_path.gsub!(/\).extension./, ').')
        end
      end

      def paths
        @paths ||= full_paths.map { |a_path| a_path.gsub("#{resource}.", '') }
      end

      def extensions
        @extensions ||= full_paths.select { |a_path| a_path.include?('extension.where') }
                                  .map { |a_path| { url: a_path[/(?<=extension.where\(url=').*(?='\))/] } }
                                  .presence
      end

      def profile_element
        @profile_element ||=
          profile_elements.find { |element| full_paths.include?(element.id) } ||
          extension_definition&.differential&.element&.find { |element| element.id == 'Extension.value[x]' }
      end

      def extension_definition
        @extension_definition ||=
          begin
            ext_definition = nil
            extensions&.each do |ext_metadata|
              ext_definition = ig_resources.profile_by_url(ext_metadata[:url])
              break if ext_definition.present?
            end
            ext_definition
          end
      end

      def comparator_expectation_extensions
        @comparator_expectation_extensions ||= param_hash['_comparator'] || []
      end

      def support_expectation(extension)
        extension['extension'].first['valueCode']
      end

      def comparator_expectation(extension)
        if extension.nil?
          'MAY'
        else
          support_expectation(extension)
        end
      end

      def comparators
        # NOTE: Hard-coded values are used because the comparator expectation
        # does not exist in the machine-readable files, but it does exist in the narrative.
        # NOTE: https://github.com/hl7au/au-fhir-core-inferno/issues/48
        special_cases_resources = %w[Observation Condition Encounter Immunization MedicationRequest]
        special_cases_comparators = %w[gt lt ge le]
        special_cases_param_ids = %w[clinical-date Condition-onset-date clinical-date MedicationRequest-authoredon]

        {}.tap do |comparators|
          param.comparator&.each_with_index do |comparator, index|
            comparators[comparator.to_sym] = if (special_cases_resources.include? group_metadata[:resource]) && (special_cases_comparators.include? comparator) && (special_cases_param_ids.include? param_hash['id'])
                                               'SHALL'
                                             else
                                               comparator_expectation(comparator_expectation_extensions[index])
                                             end
          end
        end
      end

      def type
        if profile_element.present?
          profile_element.type.first.code
        else
          # search is a variable type, eg. Condition.onsetDateTime - element
          # in profile def is Condition.onset[x]
          param.type
        end
      end

      def contains_multiple?
        if profile_element.present?
          if profile_element.id.start_with?('Extension') && extension_definition.present?
            # Find the extension instance in a AU Core profile
            target_element = profile_elements.find do |element|
              element.type.any? { |type| type.code == 'Extension' && type.profile.include?(extension_definition.url) }
            end
            target_element&.max == '*'
          else
            profile_element.max == '*'
          end
        else
          false
        end
      end

      def chain_extensions
        param_hash['_chain']
      end

      def chain_expectations
        chain_extensions.map { |extension| support_expectation(extension) }
      end

      def chain
        return nil if param.chain.blank?

        target = param.target.first
        param.chain
             .zip(chain_expectations)
             .map { |chain, expectation| { chain:, expectation:, target: } }
      end

      def multiple_or_expectation
        # NOTE: Hard-coded values are used because the multipleOr attributes
        # do not exist in the machine-readable files, but they do exist in the narrative.
        # NOTE: https://github.com/hl7au/au-fhir-core-inferno/issues/61
        # NOTE: https://github.com/hl7au/au-fhir-core-inferno/issues/63
        case group_metadata[:resource]
        when 'Procedure'
          return 'SHALL' if param_hash['id'] == 'Procedure-status'
          return 'SHOULD' if param_hash['id'] == 'clinical-code'
        when 'Observation'
          return 'SHALL' if param_hash['id'] == 'Observation-status'
          return 'SHOULD' if param_hash['id'] == 'clinical-code'
        when 'MedicationRequest'
          return 'SHALL' if param_hash['id'] == 'medications-status'
          return 'SHOULD' if param_hash['id'] == 'MedicationRequest-intent'
        when 'Immunization'
          return 'SHOULD' if param_hash['id'] == 'Immunization-vaccine-code'
        end

        return unless param_hash['_multipleOr']

        param_hash['_multipleOr']['extension'].first['valueCode']
      end

      def multiple_and_expectation
        # NOTE: Hard-coded values are used because the multipleAnd attributes
        # do not exist in the machine-readable files, but they do exist in the narrative.
        # NOTE: https://github.com/hl7au/au-fhir-core-inferno/issues/62
        case group_metadata[:resource]
        when 'Observation'
          return 'SHOULD' if param_hash['id'] == 'clinical-date'
        when 'Condition'
          return 'SHOULD' if param_hash['id'] == 'Condition-onset-date'
        when 'Encounter'
          return 'SHOULD' if param_hash['id'] == 'clinical-date'
        when 'Immunization'
          return 'SHOULD' if param_hash['id'] == 'clinical-date'
        when 'MedicationRequest'
          return 'SHOULD' if param_hash['id'] == 'MedicationRequest-authoredon'
        end
        return unless param_hash['_multipleAnd']

        param_hash['_multipleAnd']['extension'].first['valueCode']
      end

      def values
        fixed_diagnostic_result_values = %w[251739003 24701-5]
        fixed_date_value = %w[ge1950-01-01 le2050-01-01]
        # NOTE: In the current step we don't need to check the correct content of the response.
        # We should care about the correct structure of the request. In this current case we use dates just
        # to check that server can make a response for the request.
        case group_metadata[:resource]
        when 'Observation'
          return fixed_date_value if param_hash['id'] == 'clinical-date'
          return fixed_diagnostic_result_values if param_hash['id'] =='clinical-code' && group_metadata[:profile_url] == 'http://hl7.org.au/fhir/core/StructureDefinition/au-core-diagnosticresult'
        when 'Condition'
          return fixed_date_value if param_hash['id'] == 'Condition-onset-date'
        when 'Encounter'
          return fixed_date_value if param_hash['id'] == 'clinical-date'
        when 'Immunization'
          return fixed_date_value if param_hash['id'] == 'clinical-date'
        when 'MedicationRequest'
          return fixed_date_value if param_hash['id'] == 'MedicationRequest-authoredon'
        end

        values_from_fixed_codes = value_extractor.values_from_fixed_codes(profile_element, type).presence
        values_from_pattern_coding = value_extractor.values_from_pattern_coding(profile_element, type).presence
        merged_values = Array(values_from_fixed_codes) + Array(values_from_pattern_coding)

        values_from_must_supports(profile_element).presence || merged_values.presence ||
          # value_extractor.values_from_required_binding(profile_element).presence ||
          value_extractor.values_from_value_set_binding(profile_element).presence ||
          values_from_resource_metadata(paths).presence ||
          []
      end

      def values_from_must_supports(profile_element)
        return if profile_element.nil?

        short_path = profile_element.path.split('.', 2)[1]

        values_from_must_support_slices(profile_element, short_path, true).presence ||
          values_from_must_support_slices(profile_element, short_path, false).presence ||
          values_from_must_support_elements(short_path).presence ||
          []
      end

      def values_from_must_support_slices(profile_element, short_path, mandatory_slice_only)
        return unless group_metadata[:must_supports][:slices].compact.length.positive?

        group_metadata[:must_supports][:slices]
          .select { |slice| [short_path, "#{short_path}.coding"].include?(slice[:path]) }
          .map do |slice|
            slice_element = profile_elements.find { |element| slice[:slice_id] == element.id }
            next if profile_element.min.positive? && slice_element.min.zero? && mandatory_slice_only

            case slice[:discriminator][:type]
            when 'patternCoding', 'patternCodeableConcept'
              slice[:discriminator][:code]
            when 'requiredBinding'
              slice[:discriminator][:values]
            when 'value'
              slice[:discriminator][:values]
                .select { |value| value[:path] == 'coding.code' }
                .map { |value| value[:value] }
            end
          end
          .compact.flatten
      end

      def values_from_must_support_elements(short_path)
        group_metadata[:must_supports][:elements]
          .select { |element| element[:path] == "#{short_path}.coding.code" }
          .map { |element| element[:fixed_value] }
      end

      def values_from_resource_metadata(paths)
        if multiple_or_expectation == 'SHALL' || paths.any? { |path| path.downcase.include?('status') }
          value_extractor.values_from_resource_metadata(paths)
        else
          []
        end
      end

      def value_extractor
        @value_extractor ||= ValueExactor.new(ig_resources, resource, profile_elements)
      end
    end
  end
end
