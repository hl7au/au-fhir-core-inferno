# frozen_string_literal: true

require_relative 'search_test_properties'
require_relative 'search_test'

module AUCoreTestKit
  module SpecialIdentifierSearchTest
    extend Forwardable
    include SearchTest

    def_delegators 'self.class', :metadata, :provenance_metadata, :properties
    def_delegators 'properties',
                   :resource_type,
                   :search_param_names,
                   :saves_delayed_references?,
                   :first_search?,
                   :fixed_value_search?,
                   :possible_status_search?,
                   :test_medication_inclusion?,
                   :test_post_search?,
                   :token_search_params,
                   :test_reference_variants?,
                   :params_with_comparators,
                   :multiple_or_search_params,
                   :optional_multiple_or_search_params,
                   :multiple_and_search_params,
                   :optional_multiple_and_search_params,
                   :identifier_type

    def map_identifier_system_by_type(identifier_type)
      identifier_system_hash = {
        'dva' => 'http://ns.electronichealth.net.au/id/dva',
        'ihi' => 'http://ns.electronichealth.net.au/id/hi/ihi/1.0',
        'medicare' => 'http://ns.electronichealth.net.au/id/medicare-number'
      }

      identifier_system_hash[identifier_type]
    end

    def all_search_params
      @all_search_params ||=
        patient_id_list.each_with_object({}) do |patient_id, params|
          params[patient_id] ||= []
          new_params = [search_params_with_values(search_param_names, patient_id)]
          new_params.reject! do |params|
            params.any? { |_key, value| value.blank? }
          end
          params[patient_id].concat(new_params)
        end
    end

    def search_params_with_values(search_param_names, patient_id, include_system: false)
      resources = scratch_resources_for_patient(patient_id)

      if resources.empty?
        return search_param_names.each_with_object({}) do |name, params|
          value = patient_id_param?(name) ? patient_id : nil
          params[name] = value
        end
      end

      resources.each_with_object({}) do |resource, outer_params|
        results_from_one_resource = search_param_names.each_with_object({}) do |name, params|
          value = search_param_value(name, resource, include_system:)
          params[name] = value
        end

        outer_params.merge!(results_from_one_resource)
        # stop if all parameter values are found
        return outer_params if outer_params.all? { |_key, value| value.present? }
      end
    end

    def get_resource_identifiers(resource, identifier_type)
      resource.identifier.filter { |ident| ident.system == map_identifier_system_by_type(identifier_type) }
    end

    def search_param_value(_name, resource, include_system: false)
      search_value = nil
      resource_identifiers = get_resource_identifiers(resource, identifier_type)
      if resource_identifiers.length.positive?
        resource_identifier = resource_identifiers.first
        search_value = include_system ? "#{resource_identifier.system}|#{resource_identifier.value}" : resource_identifier.value.to_s
      end
      search_value&.gsub(',', '\\,')
    end

    def run_special_identifier_search_test
      skip_if !any_valid_search_params?(all_search_params), unable_to_resolve_params_message

      resources_returned =
        all_search_params.flat_map do |patient_id, params_list|
          params_list.flat_map { |params| perform_search(params, patient_id) }
        end

      skip_if resources_returned.empty?, no_resources_skip_message
    end
  end
end
