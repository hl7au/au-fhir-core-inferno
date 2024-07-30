# frozen_string_literal: true

module AUCoreTestKit
  module ReadTest
    def all_scratch_resources
      scratch_resources[:all] ||= []
    end

    def perform_read_test(resources, _reply_handler = nil)
      if resources.blank?
        resource_ids_str = fetch_resource_ids(resource_type)
        if resource_ids_str.blank?
          skip no_resources_custom_skip_message
        else
          resources_to_read = get_resources_to_read_from_arr_ids(
            resource_ids_str_to_arr(resource_ids_str),
            resource_type
          )
          assert resources_to_read.present?, "No #{resource_type} id found."
          read_and_validate_resourses_arr(resources_to_read)
        end
      else
        resources_to_read = readable_resources(resources)
        assert resources_to_read.present?, "No #{resource_type} id found."
        read_and_validate_resourses_arr(resources_to_read)
      end
    end

    def fetch_resource_ids(resource_type)
      case resource_type
      when 'Location'
        location_ids
      when 'Organization'
        organization_ids
      when 'Practitioner'
        practitioner_ids
      when 'PractitionerRole'
        practitioner_role_ids
      else
        ''
      end
    end

    def resource_ids_str_to_arr(resource_ids_str)
      resource_ids_str.split(',').map(&:strip)
    end

    def read_and_validate_resourses_arr(resources_to_read)
      resources_to_read.each do |resource|
        read_and_validate(resource)
      end
    end

    def get_resources_to_read_from_arr_ids(resource_ids_arr, resource_type)
      resource_ids_arr.map do |resource_id|
        create_reference(resource_type, resource_id)
      end
    end

    def create_reference(resource_type, resource_id)
      FHIR::Reference.new(
        reference: "#{resource_type}/#{resource_id}",
        type: resource_type
      )
    end

    def readable_resources(resources)
      resources
        .select { |resource| resource.is_a?(resource_class) || resource.is_a?(FHIR::Reference) }
        .select { |resource| (resource.is_a?(FHIR::Reference) ? resource.reference.split('/').last : resource.id).present? }
        .compact
        .uniq { |resource| resource.is_a?(FHIR::Reference) ? resource.reference.split('/').last : resource.id }
    end

    def basic_read_and_validate(resource_to_read)
      id = resource_id(resource_to_read)

      fhir_read resource_type, id

      assert_response_status(200)
      assert_resource_type(resource_type)
      assert resource.id.present? && resource.id == id, bad_resource_id_message(id)

      nil unless resource_to_read.is_a? FHIR::Reference
    end

    def read_and_validate(resource_to_read)
      basic_read_and_validate(resource_to_read)

      all_scratch_resources << resource
    end

    def read_and_validate_as_first(resource_to_read, patient_id)
      basic_read_and_validate(resource_to_read)

      all_scratch_resources.concat([resource]).uniq!
      scratch_resources_for_patient(patient_id).concat([resource]).uniq!
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

    def no_resources_custom_skip_message
      "There are no resources of the type #{resource_type} from previous tests, and you didn't provide IDs to search."
    end

    def resource_class
      FHIR.const_get(resource_type)
    end
  end
end
