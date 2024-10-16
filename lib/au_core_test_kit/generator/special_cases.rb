# frozen_string_literal: true

module AUCoreTestKit
  class Generator
    module SpecialCases
      RESOURCES_TO_EXCLUDE = %w[
        Medication
        RelatedPerson
      ].freeze

      PROFILES_TO_EXCLUDE = [].freeze

      PATIENT_IDENTIFIERS = [
        { display: 'IHI', url: 'http://ns.electronichealth.net.au/id/hi/ihi/1.0' },
        { display: 'Medicare', url: 'http://ns.electronichealth.net.au/id/medicare-number' },
        { display: 'DVA', url: 'http://ns.electronichealth.net.au/id/dva' }
      ].freeze

      PRACTITIONER_IDENTIFIERS = [
        { display: 'HPI-I', url: 'http://ns.electronichealth.net.au/id/hi/hpii/1.0' }
      ].freeze

      PRACTITIONER_ROLE_IDENTIFIERS = [
        { display: 'Medicare', url: 'http://ns.electronichealth.net.au/id/medicare-provider-number' }
      ].freeze

      ORGANIZATION_IDENTIFIERS = [
        { display: 'HPI-O', url: 'http://ns.electronichealth.net.au/id/hi/hpio/1.0' },
        { display: 'ABN', url: 'http://hl7.org.au/id/abn' }
      ].freeze

      # In the current implementation (2024.10.16/1.0.0-ci-build) there is no way
      # to get information on what search/combo search parameters SHOULD be supported
      # with the _include parameter. This information exists only in narratives.

      # https://build.fhir.org/ig/hl7au/au-fhir-core/StructureDefinition-au-core-medicationrequest.html#mandatory-search-parameters
      # https://build.fhir.org/ig/hl7au/au-fhir-core/StructureDefinition-au-core-practitionerrole.html#mandatory-search-parameters
      # https://github.com/hl7au/au-fhir-core-inferno/issues/199

      SEARCH_PARAMS_FOR_INCLUDE_BY_RESOURCE = {
        'MedicationRequest' => [
          ['patient'],
          %w[patient intent],
          %w[patient intent status],
          ['_id'],
          %w[patient intent authoredon]
        ],
        'PractitionerRole' => [
          ['identifier'],
          ['practitioner'],
          ['_id'],
          ['specialty']
        ]
      }.freeze

      class << self
        def exclude_group?(group)
          RESOURCES_TO_EXCLUDE.include?(group.resource)
        end

        def patient_au_identifiers
          PATIENT_IDENTIFIERS
        end

        def practitioner_au_identifiers
          PRACTITIONER_IDENTIFIERS
        end

        def practitionerrole_au_identifiers
          PRACTITIONER_ROLE_IDENTIFIERS
        end

        def organization_au_identifiers
          ORGANIZATION_IDENTIFIERS
        end

        def search_params_for_include_by_resource
          SEARCH_PARAMS_FOR_INCLUDE_BY_RESOURCE
        end
      end
    end
  end
end
