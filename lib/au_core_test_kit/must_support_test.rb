# frozen_string_literal: true

require_relative 'fhir_resource_navigation'
require_relative 'helpers'
require_relative 'assert_helpers'

module AUCoreTestKit
  module MustSupportTest
    extend Forwardable
    include FHIRResourceNavigation
    include AssertHelpers

    def_delegators 'self.class', :metadata

    def all_scratch_resources
      scratch_resources[:all]
    end

    def perform_must_support_test(resources)
      conditional_skip_with_msg resources.blank?, "No #{resource_type} resources were found"

      missing_elements(resources)
      missing_slices(resources)
      missing_extensions(resources)

      handle_must_support_choices if metadata.must_supports[:choices].present?

      pass if (missing_elements + missing_slices + missing_extensions).empty?
      skip_with_msg "Could not find #{missing_must_support_strings.join(', ')} element(s) in the #{resources.length} " \
           "provided #{resource_type} resource(s). To prevent this issue, please add the missing must support "\
           "elements to at least one #{resource_type} resource on the server."
    end

    def handle_must_support_choices
      missing_elements.delete_if do |element|
        choices = metadata.must_supports[:choices].find { |choice| choice[:paths]&.include?(element[:path]) }
        is_any_choice_supported?(choices)
      end

      missing_extensions.delete_if do |extension|
        choices = metadata.must_supports[:choices].find { |choice| choice[:extension_ids]&.include?(extension[:id]) }
        is_any_choice_supported?(choices)
      end

      missing_slices.delete_if do |slice|
        choices = metadata.must_supports[:choices].find { |choice| choice[:slice_names]&.include?(slice[:name]) }
        is_any_choice_supported?(choices)
      end
    end

    def is_any_choice_supported?(choices)
      choices.present? &&
        (
          choices[:paths]&.any? { |path| missing_elements.none? { |element| element[:path] == path } } ||
          choices[:extension_ids]&.any? do |extension_id|
            missing_extensions.none? do |extension|
              extension[:id] == extension_id
            end
          end ||
          choices[:slice_names]&.any? { |slice_name| missing_slices.none? { |slice| slice[:name] == slice_name } }
        )
    end

    def missing_must_support_strings
      result = missing_elements.map { |element_definition| missing_element_string(element_definition) } +
        missing_slices.map { |slice_definition| slice_definition[:slice_id] } +
        missing_extensions.map { |extension_definition| extension_definition[:id] }

      result.map { |missing_element| "'#{missing_element}'" }
    end

    def missing_element_string(element_definition)
      if element_definition[:fixed_value].present?
        "#{element_definition[:path]}:#{element_definition[:fixed_value]}"
      else
        element_definition[:path]
      end
    end

    def exclude_uscdi_only_test?
      config.options[:exclude_uscdi_only_test] == true
    end

    def must_support_extensions
      if exclude_uscdi_only_test?
        metadata.must_supports[:extensions].reject { |extension| extension[:uscdi_only] }
      else
        metadata.must_supports[:extensions]
      end
    end

    def missing_extensions(resources = [])
      @missing_extensions ||=
        must_support_extensions.select do |extension_definition|
          resources.none? do |resource|
            resource_extensions_url_arr = Helpers.extract_extensions_from_resource(resource).map { |ext| ext['url'] }
            resource_extensions_url_arr.include? extension_definition[:url]
          end
        end
    end

    def must_support_elements
      if exclude_uscdi_only_test?
        metadata.must_supports[:elements].reject { |element| element[:uscdi_only] }
      else
        metadata.must_supports[:elements]
      end
    end

    def missing_elements(resources = [])
      @missing_elements ||=
        must_support_elements.select do |element_definition|
          resources.none? do |resource|
            path = element_definition[:path] # .delete_suffix('[x]')
            value_found = find_a_value_at(resource, path) do |value|
              value_without_extensions =
                value.respond_to?(:to_hash) ? value.to_hash.reject { |key, _| key == 'extension' } : value

              (value_without_extensions.present? || value_without_extensions == false) &&
                (element_definition[:fixed_value].blank? || value == element_definition[:fixed_value])
            end
            # Note that false.present? => false, which is why we need to add this extra check
            value_found.present? || value_found == false
          end
        end
      @missing_elements
    end

    def must_support_slices
      if exclude_uscdi_only_test?
        metadata.must_supports[:slices].reject { |slice| slice[:uscdi_only] }
      else
        metadata.must_supports[:slices]
      end
    end

    def missing_slices(resources = [])
      @missing_slices ||=
        must_support_slices.select do |slice|
          resources.none? do |resource|
            path = slice[:path] # .delete_suffix('[x]')
            find_slice(resource, path, slice[:discriminator]).present?
          end
        end
    end

    def find_slice(resource, path, discriminator)
      find_a_value_at(resource, path) do |element|
        case discriminator[:type]
        when 'patternCodeableConcept'
          coding_path = discriminator[:path].present? ? "#{discriminator[:path]}.coding" : 'coding'
          find_a_value_at(element, coding_path) do |coding|
            coding.code == discriminator[:code] && coding.system == discriminator[:system]
          end
        when 'patternCoding'
          coding_path = discriminator[:path].present? ? discriminator[:path] : ''
          find_a_value_at(element, coding_path) do |coding|
            coding.code == discriminator[:code] && coding.system == discriminator[:system]
          end
        when 'patternIdentifier'
          find_a_value_at(element, discriminator[:path]) { |identifier| identifier.system == discriminator[:system] }
        when 'value'
          values = discriminator[:values].map { |value| value.merge(path: value[:path].split('.')) }
          find_slice_by_values(element, values)
        when 'type'
          case discriminator[:code]
          when 'Date'
            begin
              Date.parse(element)
            rescue ArgumentError
              false
            end
          when 'DateTime'
            begin
              DateTime.parse(element)
            rescue ArgumentError
              false
            end
          when 'String'
            element.is_a? String
          else
            element.is_a? FHIR.const_get(discriminator[:code])
          end
        when 'requiredBinding'
          coding_path = discriminator[:path].present? ? "#{discriminator[:path]}.coding" : 'coding'
          find_a_value_at(element, coding_path) { |coding| discriminator[:values].include?(coding.code) }
        end
      end
    end

    def find_slice_by_values(element, value_definitions)
      path_prefixes = value_definitions.map { |value_definition| value_definition[:path].first }.uniq
      Array.wrap(element).find do |el|
        path_prefixes.all? do |path_prefix|
          value_definitions_for_path =
            value_definitions
            .select { |value_definition| value_definition[:path].first == path_prefix }
            .each { |value_definition| value_definition[:path].shift }

          find_a_value_at(el, path_prefix) do |el_found|
            child_element_value_definitions, current_element_value_definitions =
              value_definitions_for_path.partition { |value_definition| value_definition[:path].present? }

            current_element_values_match =
              current_element_value_definitions
              .all? { |value_definition| value_definition[:value] == el_found }

            child_element_values_match =
              if child_element_value_definitions.present?
                find_slice_by_values(el_found, child_element_value_definitions)
              else
                true
              end

            current_element_values_match && child_element_values_match
          end
        end
      end
    end
  end
end
