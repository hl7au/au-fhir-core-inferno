# frozen_string_literal: true

module AUCoreTestKit
  module FHIRResourceNavigation
    DAR_EXTENSION_URL = 'http://hl7.org/fhir/StructureDefinition/data-absent-reason'

    def resolve_path(elements, path)
      elements = Array.wrap(elements)
      return elements if path.blank?

      paths = path.split(/(?<!hl7)\./)
      segment = paths.first
      remaining_path = paths.drop(1).join('.')

      elements.flat_map do |element|
        child = get_next_value(element, segment)
        resolve_path(child, remaining_path)
      end.compact
    end

    def is_extension?(str)
      !!str.match(%r{extension\('https?://[^\s]+?\)\.value})
    end

    def get_extension_url(str)
      match = str.match(/extension\('([^']+)'\)\.value/)
      match ? match[1] : nil
    end

    def get_value_from_extension(element, extension_url)
      extension_elements = element.extension.filter { |ext| ext.url == extension_url }
      return nil unless extension_elements.length.positive?

      extension_element = extension_elements.first
      case extension_url
      when 'http://hl7.org.au/fhir/StructureDefinition/indigenous-status'
        extension_element.valueCoding
      when 'http://hl7.org/fhir/StructureDefinition/individual-genderIdentity'
        extension_element.extension.first.valueCodeableConcept
      else
        extension_element.valueCoding
      end
    end

    def find_a_value_at(element, path, include_dar: false, &block)
      return nil if element.nil?

      return get_value_from_extension(element, get_extension_url(path)) if is_extension?(path)

      elements = Array.wrap(element)
      if path.empty?
        unless include_dar
          elements = elements.reject do |el|
            el.respond_to?(:extension) && el.extension.any? { |ext| ext.url == DAR_EXTENSION_URL }
          end
        end

        return elements.find(&block) if block_given?

        return elements.first
      end

      path_segments = path.split(/(?<!hl7)\./)

      segment = path_segments.shift.delete_suffix('[x]').gsub(/^class$/, 'local_class').gsub(/\[x\]:/, ':').to_sym
      no_elements_present =
        elements.none? do |element|
          child = get_next_value(element, segment)
          child.present? || child == false
        end
      return nil if no_elements_present

      remaining_path = path_segments.join('.')
      elements.each do |element|
        child = get_next_value(element, segment)
        element_found =
          if block_given?
            find_a_value_at(child, remaining_path, include_dar:, &block)
          else
            find_a_value_at(child, remaining_path, include_dar:)
          end
        return element_found if element_found.present? || element_found == false
      end

      nil
    end

    def get_next_value(element, property)
      extension_url = property[/(?<=where\(url=').*(?='\))/]
      if extension_url.present?
        element.url == extension_url ? element : nil
      elsif property.to_s.include?(':') && !property.to_s.include?('url')
        find_slice_via_discriminator(element, property)

      else
        element.send(property)
      end
    rescue NoMethodError
      nil
    end

    def find_slice_via_discriminator(element, property)
      element_name = property.to_s.split(':')[0].gsub(/^class$/, 'local_class')
      slice_name = property.to_s.split(':')[1].gsub(/^class$/, 'local_class')
      if metadata.present?
        slice_by_name = metadata.must_supports[:slices].find { |slice| slice[:slice_name] == slice_name }
        discriminator = slice_by_name[:discriminator]
        slices = Array.wrap(element.send(element_name))
        slices.find do |slice|
          case discriminator[:type]
          when 'patternCodeableConcept'
            slice_value = discriminator[:path].present? ? slice.send((discriminator[:path]).to_s).coding : slice.coding
            slice_value.any? { |coding| coding.code == discriminator[:code] && coding.system == discriminator[:system] }
          when 'patternCoding'
            slice_value = discriminator[:path].present? ? slice.send(discriminator[:path]) : slice
            slice_value.code == discriminator[:code] && slice_value.system == discriminator[:system]
          when 'patternIdentifier'
            slice.identifier.system == discriminator[:system]
          when 'value'
            values = discriminator[:values].map { |value| value.merge(path: value[:path].split('.')) }
            verify_slice_by_values(slice, values)
          when 'type'
            case discriminator[:code]
            when 'Date'
              begin
                Date.parse(slice)
              rescue ArgumentError
                false
              end
            when 'DateTime'
              begin
                DateTime.parse(slice)
              rescue ArgumentError
                false
              end
            when 'String'
              slice.is_a? String
            else
              slice.is_a? FHIR.const_get(discriminator[:code])
            end
          when 'requiredBinding'
            discriminator[:path].present? ? slice.send((discriminator[:path]).to_s).coding : slice.coding
            slice_value { |coding| discriminator[:values].include?(coding.code) }
          end
        end
      else
        # TODO: Error handling for if this file doesn't have access to metadata for some reason (begin/rescue with StandardError?)
      end
    end

    def verify_slice_by_values(element, value_definitions)
      path_prefixes = value_definitions.map { |value_definition| value_definition[:path].first }.uniq
      path_prefixes.all? do |path_prefix|
        value_definitions_for_path =
          value_definitions
          .select { |value_definition| value_definition[:path].first == path_prefix }
          .each { |value_definition| value_definition[:path].shift }
        find_a_value_at(element, path_prefix) do |el_found|
          child_element_value_definitions, current_element_value_definitions =
            value_definitions_for_path.partition { |value_definition| value_definition[:path].present? }

          current_element_values_match =
            current_element_value_definitions
            .all? { |value_definition| value_definition[:value] == el_found }

          child_element_values_match =
            if child_element_value_definitions.present?
              verify_slice_by_values(el_found, child_element_value_definitions)
            else
              true
            end
          current_element_values_match && child_element_values_match
        end
      end
    end
  end
end
