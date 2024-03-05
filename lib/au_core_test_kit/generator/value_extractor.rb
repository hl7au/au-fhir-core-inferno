module AUCoreTestKit
  class Generator
    class ValueExactor
      attr_accessor :ig_resources, :resource, :profile_elements

      def initialize(ig_resources, resource, profile_elements)
        self.ig_resources = ig_resources
        self.resource = resource
        self.profile_elements = profile_elements
      end


      def values_from_required_binding(profile_element)
        return [] unless profile_element&.max == '*'

        profile_elements
          .select do |element|
            element.path == profile_element.path && element.binding&.strength == 'required'
          end
          .map { |element| values_from_value_set_binding(element) }
          .flatten.compact
      end

      def values_from_fixed_codes(profile_element, type)
        return [] unless type == 'CodeableConcept'

        profile_elements
          .select do
            |element| element.path == "#{profile_element.path}.coding.code" && element.fixedCode.present?
          end
          .map { |element| element.fixedCode }
      end

      def values_from_pattern_coding(profile_element, type)
        return [] unless type == 'CodeableConcept'

        profile_elements
          .select do |element|
            element.path == "#{profile_element.path}.coding" && element.patternCoding.present?
          end
          .map { |element| element.patternCoding.code }
      end

      def values_from_pattern_codeable_concept(profile_element, type)
        return [] unless type == 'CodeableConcept'

        profile_elements
          .select do |element|
            element.path == profile_element.path && element.patternCodeableConcept.present? && element.min > 0
          end
          .map { |element| element.patternCodeableConcept.coding.first.code }
      end

      def value_set_binding(the_element)
        the_element&.binding
      end

      def value_set(the_element)
        ig_resources.value_set_by_url(value_set_binding(the_element)&.valueSet)
      end

      def bound_systems(the_element)
        bound_systems_from_valueset(value_set(the_element))
      end

      def bound_systems_from_valueset(value_set)
        systems = value_set&.compose&.include&.map do |include|
          if include.concept.present?
            include
          elsif include.system.present? && include.filter&.empty? # Cannot process intensional value set with filters
            ig_resources.code_system_by_url(include.system)
          elsif include.valueSet.present?
            include.valueSet.map do |vs|
              a_value_set = ig_resources.value_set_by_url(vs)
              bound_systems_from_valueset(a_value_set)
            end
          end
        end&.flatten&.compact

        systems
      end

      def values_from_value_set_binding(the_element)
        bound_systems = bound_systems(the_element)

        return [] if bound_systems.blank?

        bound_systems.flat_map { |system| system.concept.map { |code| code.code } }.uniq
      end

      def fhir_metadata(current_path)
        FHIR.const_get(resource)::METADATA[current_path]
      end

      def values_from_resource_metadata(paths)
        values = []

        paths.each do |current_path|
          current_metadata = fhir_metadata(current_path)

          if current_metadata&.dig('valid_codes').present?
            values = values + current_metadata['valid_codes'].values.flatten
          end
        end

        values
      end
    end
  end
end