module Helpers
  def self.extract_extensions_from_resource(resource, extensions=[])
    resource_hash = convert_resource_to_hash(resource)
    process_resource_element(resource_hash, extensions)
    extensions
  end

  private

  def self.convert_resource_to_hash(resource)
    if defined?(FHIR) && resource.is_a?(FHIR::Model)
      resource.to_hash
    else
      resource
    end
  end

  def self.process_resource_element(element, extensions)
    case element
    when Hash
      if element['extension'].is_a?(Array)
        extensions.concat(element['extension'])
      end
      element.each do |_, value|
        process_resource_element(value, extensions)
      end
    when Array
      element.each { |item| process_resource_element(item, extensions) }
    end
  end
end
