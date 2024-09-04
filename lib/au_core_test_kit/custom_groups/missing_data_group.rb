# frozen_string_literal: true

require_relative '../helpers'

module AUCoreTestKit
  module AUCoreV100
    class MissingDataGroup < Inferno::TestGroup
      RESOURCE_PROFILES = %w[
        http://hl7.org.au/fhir/core/StructureDefinition/au-core-allergyintolerance
        http://hl7.org.au/fhir/core/StructureDefinition/au-core-condition
        http://hl7.org.au/fhir/core/StructureDefinition/au-core-encounter
        http://hl7.org.au/fhir/core/StructureDefinition/au-core-immunization
        http://hl7.org.au/fhir/core/StructureDefinition/au-core-location
        http://hl7.org.au/fhir/core/StructureDefinition/au-core-medication
        http://hl7.org.au/fhir/core/StructureDefinition/au-core-medicationrequest
        http://hl7.org.au/fhir/core/StructureDefinition/au-core-organization
        http://hl7.org.au/fhir/core/StructureDefinition/au-core-patient
        http://hl7.org.au/fhir/core/StructureDefinition/au-core-practitioner
        http://hl7.org.au/fhir/core/StructureDefinition/au-core-practitionerrole
        http://hl7.org.au/fhir/core/StructureDefinition/au-core-procedure
        http://hl7.org.au/fhir/core/StructureDefinition/au-core-bodyweight
        http://hl7.org.au/fhir/core/StructureDefinition/au-core-bloodpressure
        http://hl7.org.au/fhir/core/StructureDefinition/au-core-bodyheight
        http://hl7.org.au/fhir/core/StructureDefinition/au-core-diagnosticresult-path
        http://hl7.org.au/fhir/core/StructureDefinition/au-core-bodytemp
        http://hl7.org.au/fhir/core/StructureDefinition/au-core-heartrate
        http://hl7.org.au/fhir/core/StructureDefinition/au-core-waistcircum
        http://hl7.org.au/fhir/core/StructureDefinition/au-core-resprate
        http://hl7.org.au/fhir/core/StructureDefinition/au-core-diagnosticresult
        http://hl7.org.au/fhir/core/StructureDefinition/au-core-smokingstatus
      ].freeze

      id :au_core_missing_data_group
      title 'Missing Data Tests'
      short_description 'Verify that the server is capable of representing missing data.'
      description %(
        The [AU Core Missing Data
        Guidance](https://build.fhir.org/ig/hl7au/au-fhir-core/general-requirements.html#missing-data)
        gives instructions on how to represent various types of missing data.

        In the previous resource tests, each resource returned from the server was
        checked for the presence of missing data. These tests will pass if the
        specified method of representing missing data was observed in the earlier
        tests.

        These tests check the capability to support the
        [DataAbsentReason extension](http://hl7.org/fhir/R4/extension-data-absent-reason.html),
        and the “unknown” concept code from the [DataAbsentReason Code System](http://terminology.hl7.org/CodeSystem/data-absent-reason).
        It is intended to support manual verification (or other testing mechanism)
        to fully test conformance to AU Core Missing Data and Suppressed Data requirements.
      )
      run_as_group

      test do
        id :au_core_missing_data
        title 'Server represents missing data with the DataAbsentReason Extension and CodeSystem'
        description %(
          For non-coded data elements, servers SHALL use the DataAbsentReason
          Extension to represent missing data in a required field.

          For coded data elements with example, preferred, or extensible binding
          strengths to ValueSets which do not include an appropriate "unknown"
          code, servers SHALL use the "unknown" code from the DataAbsentReason
          CodeSystem.
        )

        run do
          profiles = RESOURCE_PROFILES.map { |profile| profile.split('/').last.gsub('-', '_').gsub('au_core_', '') }
          profiles.each do |profile|
            resource_type_key_string = "#{profile}_resources"
            resources = scratch[resource_type_key_string.to_sym] || {}
            all_resources = resources[:all] || []
            all_resources = Helpers.return_uniq_list_resources(all_resources)
            next unless all_resources.count.positive?

            all_resources.each do |resource|
              dar_codes_exists = Helpers.check_for_dar(resource)
              dar_extension_exists = Helpers.check_for_dar_extension(resource)

              info "Data Absent Reason code found for #{resource.resourceType} with id: #{resource.id}" if dar_codes_exists
              info "Data Absent Reason extension found for #{resource.resourceType} with id: #{resource.id}" if dar_extension_exists
            end
          end
        end
      end
    end
  end
end
