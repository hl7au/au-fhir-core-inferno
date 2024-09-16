# frozen_string_literal: true

require_relative 'fhir_resource_navigation'
require_relative 'assert_helpers'

module AUCoreTestKit
  module ReferenceResolutionTest
    extend Forwardable
    include FHIRResourceNavigation
    include AssertHelpers

    def_delegators 'self.class', :metadata

    def perform_reference_resolution_test(resources)
      conditional_skip_with_msg resources.blank?, no_resources_skip_message

      pass if unresolved_references(resources).empty?

      skip_with_msg "Could not resolve and validate any Must Support references for #{unresolved_references_strings.join(', ')}"
    end

    def unresolved_references_strings
      unresolved_reference_hash =
        unresolved_references.each_with_object(Hash.new { |hash, key| hash[key] = [] }) do |missing, hash|
          hash[missing[:path]] << missing[:target_profile]
        end
      unresolved_reference_hash.map do |path, profiles|
        "#{path} element: Reference#{"(#{profiles.join('|')})" unless profiles.first.empty?}"
      end
    end

    def record_resolved_reference(reference, target_profile)
      saved_reference = resolved_references.find { |item| item[:reference] == reference.reference }

      if saved_reference.present?
        saved_reference[:profiles] << target_profile if target_profile.present? && !saved_reference[:profiles].include?(target_profile)
      else
        saved_reference = {
          reference: reference.reference,
          profiles: []
        }

        saved_reference[:profiles] << target_profile if target_profile.present?
        resolved_references.add(saved_reference)
      end
    end

    def is_reference_resolved?(reference, target_profile)
      resolved_references.any? do |item|
        item[:reference] == reference.reference &&
          (
            target_profile.blank? || item[:profiles].include?(target_profile)
          )
      end
    end

    def resolved_references
      scratch[:resolved_references] ||= Set.new
    end

    def no_resources_skip_message
      "No #{resource_type} resources appear to be available. " \
      'Please use patients with more information.'
    end

    def must_support_references
      metadata.must_supports[:elements].select do |element_definition|
        element_definition[:types]&.include?('Reference')
      end
    end

    def must_support_references_with_target_profile
      # mapping array of target_profiles to array of {path, target_profile} pair
      must_support_references.map do |element_definition|
        (element_definition[:target_profiles] || ['']).map do |target_profile|
          {
            path: element_definition[:path],
            target_profile:
          }
        end
      end.flatten
    end

    def unresolved_references(resources = [])
      @unresolved_references ||=
        must_support_references_with_target_profile.select do |reference_path_profile_pair|
          path = reference_path_profile_pair[:path]
          target_profile = reference_path_profile_pair[:target_profile]

          found_one_reference = false

          resolve_one_reference = resources.any? do |resource|
            value_found = resolve_path(resource, path)
            next if value_found.empty?

            found_one_reference = true

            value_found.any? do |reference|
              validate_reference_resolution(resource, reference, target_profile)
            end
          end

          found_one_reference && !resolve_one_reference
        end

      if metadata.must_supports[:choices].present?
        @unresolved_references.delete_if do |reference|
          choice_profiles = metadata.must_supports[:choices].find do |choice|
            choice[:target_profiles]&.include?(reference[:target_profile])
          end

          choice_profiles.present? &&
            choice_profiles[:target_profiles]&.any? do |profile|
              @unresolved_references.none? do |element|
                element[:target_profile] == profile
              end
            end
        end
      end

      @unresolved_references
    end

    def validate_reference_resolution(resource, reference, target_profile)
      return true if is_reference_resolved?(reference, target_profile)

      if reference.contained?
        # if reference_id is blank it is referring to itself, so we know it exists
        return true if reference.reference_id.blank?

        return resource.contained.any? do |contained_resource|
                 contained_resource&.id == reference.reference_id &&
                 resource_is_valid_with_target_profile?(contained_resource, target_profile)
               end
      end

      reference_type = reference.resource_type
      reference_id = reference.reference_id

      resolved_resource =
        begin
          if reference.relative?
            begin
              reference.resource_class
            rescue NameError
              return false
            end

            fhir_read(reference_type, reference_id)&.resource
          elsif reference.base_uri.chomp('/') == fhir_client.instance_variable_get(:@base_service_url).chomp('/')
            fhir_read(reference_type, reference_id)&.resource
          else
            get(reference.reference)&.resource
          end
        rescue StandardError => e
          Inferno::Application['logger'].error("Unable to resolve reference #{reference.reference}")
          Inferno::Application['logger'].error(e.full_message)
          return false
        end

      return false unless resolved_resource&.resourceType == reference_type && resolved_resource&.id == reference_id

      return false unless resource_is_valid_with_target_profile?(resolved_resource, target_profile)

      record_resolved_reference(reference, target_profile)
      true
    end

    def resource_is_valid_with_target_profile?(resource, target_profile)
      return true if target_profile.blank?

      # NOTE: Special case: terminology server don't have a specimen v0.3.0
      target_profile = "#{target_profile}|4.2.2-ballot" if target_profile == 'http://hl7.org.au/fhir/StructureDefinition/au-specimen'

      # Only need to know if the resource is valid.
      # Calling resource_is_valid? causes validation errors to be logged.
      validator = find_validator(:default)

      target_profile_with_version = target_profile.include?('|') ? target_profile : "#{target_profile}|#{metadata.profile_version}"

      validator_response = validator.validate(resource, target_profile_with_version)
      outcome = validator.operation_outcome_from_hl7_wrapped_response(validator_response)

      message_hashes = outcome.issue&.map { |issue| validator.message_hash_from_issue(issue, resource) } || []

      message_hashes.concat(validator.additional_validation_messages(resource, target_profile_with_version))

      validator.filter_messages(message_hashes)

      message_hashes.none? { |message_hash| message_hash[:type] == 'error' }
    end
  end
end
