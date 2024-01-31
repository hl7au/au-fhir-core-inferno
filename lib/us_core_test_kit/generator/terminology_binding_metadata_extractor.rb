module USCoreTestKit
  class Generator
    class TerminologyBindingMetadataExtractor
      attr_accessor :profile_elements, :ig_resources, :resource

      def initialize(profile_elements, ig_resources, resource)
        self.profile_elements = profile_elements
        self.ig_resources = ig_resources
        self.resource = resource
      end

      def terminology_bindings
        (element_terminology_bindings + extension_terminology_bindings).compact
        # add_terminology_bindings_from_extensions
        # profile_elements.select { |element| element.type&.first&.code == 'Extension' }
        #   .each { |extension| add_terminology_bindings_from_extension(extension) }
      end

      def element_has_fixed_value?(element)
        case element.type.first.code
        when 'Quantity'
          code = profile_elements.find { |e| e.path == "#{element.path}.code" }
          system = profile_elements.find { |e| e.path == "#{element.path}.system" }
          code&.fixedCode || system&.fixedUri
        when 'code'
          element.fixedCode.present?
        end
      end

      def element_has_optional_binding_slice?(element)
        element.sliceName.present? && element.min == 0
      end

      def profile_elements_with_bindings
        profile_elements
          .select { |element| element.binding.present? && element.binding.strength == 'required'}
          .reject { |element| element_has_fixed_value?(element) || element_has_optional_binding_slice?(element) }
      end



      def element_terminology_bindings
        profile_elements_with_bindings.map do |element|
          binding = {
            type: element.type.first.code,
            strength: element.binding.strength,
            # Goal.target.detail has an unbound binding
            system: element.binding.valueSet&.split('|')&.first,
            path: element.path.gsub('[x]', '').gsub("#{resource}.", '')
          }

          if element.sliceName.present? && element.min > 0
            binding[:required_binding_slice] = true
          end

          binding
        end
      end

      def extension_profile_elements
        profile_elements
          .select { |element| element.type&.first&.code == 'Extension' }
          .select { |element| extension_profile_url(element).present? }
      end

      def extension_profile_url(extension)
        extension.type.first.profile&.first
      end

      def extension_terminology_bindings
        extension_profile_elements
          .flat_map do |extension_profile_element|
            url = extension_profile_url(extension_profile_element)
            extension = ig_resources.profile_by_url(url)

            # TODO: Temporaray fix for extension defined out of US Core. FI-1623
            next if extension.nil?

            elements = extension.snapshot.element
            elements_with_bindings = elements.select do |element|
              element.binding.present? && !element.id.include?('Extension.extension')
            end

            elements_with_bindings.map do |element|
              {
                type: element.type.first.code,
                strength: element.binding.strength,
                system: element.binding.valueSet&.split('|')&.first,
                path: element.path.gsub('[x]', '').gsub('Extension.', ''),
                extensions: [url]
              }
            end + nested_extension_terminology_bindings(elements, url)
          end
      end

      def nested_extension_terminology_bindings(elements, extension_url)
        nested_extensions = elements.select { |element| element.path == 'Extension.extension' }
        nested_extensions.flat_map do |nested_extension|
          nested_extension_element = elements.find { |element| element.id == "#{nested_extension.id}.url" }
          next unless nested_extension_element.present?

          nested_extension_url = nested_extension_element.fixedUri
          nested_elements_with_bindings = elements.select do |element|
            element.id.include?(nested_extension.id) && element.binding.present?
          end

          nested_elements_with_bindings.map do |element|
            {
              type: element.type.first.code,
              strength: element.binding.strength,
              system: element.binding.valueSet&.split('|')&.first,
              path: element.path.gsub('[x]', '').gsub('Extension.extension.', ''),
              extensions: [extension_url, nested_extension_url]
            }
          end
        end
      end
    end
  end
end
