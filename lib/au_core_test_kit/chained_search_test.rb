# frozen_string_literal: true

require_relative 'search_test_properties'
require_relative 'search_test'

module AUCoreTestKit
  module ChainedSearchTest
    extend Forwardable
    include SearchTest

    def_delegators 'self.class', :metadata, :provenance_metadata, :properties
    def_delegators 'properties',
                   :resource_type,
                   :search_param_names

    def extract_target_resource_from_chained_search_parameter(search_param)
      search_param.split(':').second.split('.').first
    end

    def get_resources_identifier(resources)
      resources.map do |r|
        r.identifier.map(&:value)
      end.flatten
    end

    def all_chain_identifier_values(patient_id_list, all_resources, chain_target)
      patient_id_list.map do |patient_id|
        get_resources_identifier(
          all_resources[patient_id].filter { |r| r.resourceType == chain_target }
        )
      end.flatten
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

      search_and_check_response({ search_param => all_values.sample })
    end
  end
end
