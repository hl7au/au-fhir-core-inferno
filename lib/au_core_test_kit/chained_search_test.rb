# frozen_string_literal: true

require_relative 'date_search_validation'
require_relative 'fhir_resource_navigation'
require_relative 'search_test_properties'

module AUCoreTestKit
  module ChainedSearchTest
    extend Forwardable
    include DateSearchValidation
    include FHIRResourceNavigation

    def_delegators 'self.class', :metadata, :provenance_metadata, :properties
    def_delegators 'properties',
                   :resource_type,
                   :search_param_names

    def any_valid_search_params?(search_params)
      search_params.any? { |_patient_id, params| params.present? }
    end

    def extract_target_resource_from_chained_search_parameter(search_param)
      search_param.split(':').second.split('.').first
    end

    def get_resources_identifier(resources)
      result = []

      resources.each do |r|
        r.identifier.each do |ident|
          result << ident.value
        end
      end

      result
    end

    def all_chain_identifier_values(patient_id_list, all_resources, chain_target)
      result = []
      patient_id_list.each do |patient_id|
        all_patient_resources = all_resources[patient_id]
        target_resources = all_patient_resources.filter { |r| r.resourceType == chain_target }
        result << get_resources_identifier(target_resources)
      end
      result.flatten
    end

    def run_chain_search_test
      run_chain_search_test_clean(
        search_param_names[0],
        patient_id_list,
        scratch[:patient_resources]
      )
    end

    def run_chain_search_test_clean(search_param, patient_id_list, all_patients_resources)
      all_values = all_chain_identifier_values(
        patient_id_list, all_patients_resources,
        extract_target_resource_from_chained_search_parameter(search_param)
      )

      skip_if all_values.empty?, "I don't have values to perform search"

      all_values.each do |val|
        search_and_check_response({ search_param => val })
      end
    end

    def search_and_check_response(params, resource_type = self.resource_type)
      fhir_search(resource_type, params:)

      check_search_response
    end

    def check_search_response
      assert_response_status(200)
      assert_resource_type(:bundle)
    end

    def patient_id_list
        return [nil] unless respond_to? :patient_ids
  
        patient_ids.split(',').map(&:strip)
    end
  end
end
