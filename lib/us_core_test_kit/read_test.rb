module USCoreTestKit
  module ReadTest
    def all_scratch_resources
      scratch_resources[:all] ||= []
    end

    def perform_read_test(resources, reply_handler = nil)
      skip_if resources.blank?, no_resources_skip_message

      resources_to_read = readable_resources(resources)

      assert resources_to_read.present?, "No #{resource_type} id found."

      if config.options[:read_all_resources]
        resources_to_read.each do |resource|
          read_and_validate(resource)
        end
      else
        read_and_validate(resources_to_read.first)
      end
    end

    def readable_resources(resources)
      resources
        .select { |resource| resource.is_a?(resource_class) || resource.is_a?(FHIR::Reference) }
        .select { |resource| (resource.is_a?(FHIR::Reference) ? resource.reference.split('/').last : resource.id).present? }
        .compact
        .uniq { |resource| resource.is_a?(FHIR::Reference) ? resource.reference.split('/').last : resource.id }
    end

    def read_and_validate(resource_to_read)
      id = resource_id(resource_to_read)

      fhir_read resource_type, id

      assert_response_status(200)
      assert_resource_type(resource_type)
      assert resource.id.present? && resource.id == id, bad_resource_id_message(id)

      if resource_to_read.is_a? FHIR::Reference
        all_scratch_resources << resource
      end
    end

    def resource_id(resource)
      resource.is_a?(FHIR::Reference) ? resource.reference.split('/').last : resource.id
    end

    def no_resources_skip_message
      "No #{resource_type} resources appear to be available. " \
      'Please use patients with more information.'
    end

    def bad_resource_id_message(expected_id)
      "Expected resource to have id: `#{expected_id.inspect}`, but found `#{resource.id.inspect}`"
    end

    def resource_class
      FHIR.const_get(resource_type)
    end
  end
end
