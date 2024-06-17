# frozen_string_literal: true

require 'tls_test_kit'
require_relative '../../helpers'
require_relative '../capability_statement/conformance_support_test'
require_relative '../capability_statement/fhir_version_test'
require_relative '../capability_statement/json_support_test'
require_relative '../capability_statement/xml_support_test'
require_relative './profile_support_test'

module AUCoreTestKit
  module AUCoreV030_BALLOT
    class CapabilityStatementGroup < Inferno::TestGroup
      id :au_core_v030_ballot_capability_statement
      title 'Capability Statement'
      short_description 'Retrieve information about supported server functionality using the FHIR capabilties interaction.'
      description Helpers.get_capability_statement_group_description_text('Capability Statement')
      run_as_group

      PROFILES = {
        'AllergyIntolerance' => ['http://hl7.org.au/fhir/core/StructureDefinition/au-core-allergyintolerance'],
        'Condition' => ['http://hl7.org.au/fhir/core/StructureDefinition/au-core-condition'],
        'DiagnosticReport' => ['http://hl7.org.au/fhir/core/StructureDefinition/au-core-diagnosticreport'],
        'DocumentReference' => ['http://hl7.org.au/fhir/core/StructureDefinition/au-core-documentreference'],
        'Encounter' => ['http://hl7.org.au/fhir/core/StructureDefinition/au-core-encounter'],
        'HealthcareService' => ['http://hl7.org.au/fhir/core/StructureDefinition/au-core-healthcareservice'],
        'Immunization' => ['http://hl7.org.au/fhir/core/StructureDefinition/au-core-immunization'],
        'Location' => ['http://hl7.org.au/fhir/core/StructureDefinition/au-core-location'],
        'Medication' => ['http://hl7.org.au/fhir/core/StructureDefinition/au-core-medication'],
        'MedicationRequest' => ['http://hl7.org.au/fhir/core/StructureDefinition/au-core-medicationrequest'],
        'MedicationStatement' => ['http://hl7.org.au/fhir/core/StructureDefinition/au-core-medicationstatement'],
        'Observation' => ['http://hl7.org.au/fhir/core/StructureDefinition/au-core-bloodpressure',
                          'http://hl7.org.au/fhir/core/StructureDefinition/au-core-bmi',
                          'http://hl7.org.au/fhir/core/StructureDefinition/au-core-bodyheight',
                          'http://hl7.org.au/fhir/core/StructureDefinition/au-core-bodytemp',
                          'http://hl7.org.au/fhir/core/StructureDefinition/au-core-bodyweight',
                          'http://hl7.org.au/fhir/core/StructureDefinition/au-core-diagnosticresult-imag',
                          'http://hl7.org.au/fhir/core/StructureDefinition/au-core-diagnosticresult-path',
                          'http://hl7.org.au/fhir/core/StructureDefinition/au-core-lipid-result',
                          'http://hl7.org.au/fhir/core/StructureDefinition/au-core-diagnosticresult',
                          'http://hl7.org.au/fhir/core/StructureDefinition/au-core-headcircum',
                          'http://hl7.org.au/fhir/core/StructureDefinition/au-core-heartrate',
                          'http://hl7.org.au/fhir/core/StructureDefinition/au-core-observation',
                          'http://hl7.org.au/fhir/core/StructureDefinition/au-core-oxygensat',
                          'http://hl7.org.au/fhir/core/StructureDefinition/au-core-resprate',
                          'http://hl7.org.au/fhir/core/StructureDefinition/au-core-sexassignedatbirth',
                          'http://hl7.org.au/fhir/core/StructureDefinition/au-core-smokingstatus',
                          'http://hl7.org.au/fhir/core/StructureDefinition/au-core-vitalspanel',
                          'http://hl7.org.au/fhir/core/StructureDefinition/au-core-waistcircum'].freeze,
        'Organization' => ['http://hl7.org.au/fhir/core/StructureDefinition/au-core-organization'],
        'Patient' => ['http://hl7.org.au/fhir/core/StructureDefinition/au-core-patient'],
        'Practitioner' => ['http://hl7.org.au/fhir/core/StructureDefinition/au-core-practitioner'],
        'PractitionerRole' => ['http://hl7.org.au/fhir/core/StructureDefinition/au-core-practitionerrole'],
        'Procedure' => ['http://hl7.org.au/fhir/core/StructureDefinition/au-core-procedure'],
        'Provenance' => ['http://hl7.org.au/fhir/core/StructureDefinition/au-core-provenance'],
        'ServiceRequest' => ['http://hl7.org.au/fhir/core/StructureDefinition/au-core-servicerequest']
      }.freeze

      test from: :tls_version_test,
           id: :standalone_auth_tls,
           title: 'FHIR server secured by transport layer security',
           description: %(
            Systems **SHALL** use TLS version 1.2 or higher for all transmissions
            not taking place over a secure network connection.
          ),
           config: {
             options: { minimum_allowed_version: OpenSSL::SSL::TLS1_2_VERSION }
           }
      test from: :au_core_conformance_support
      test from: :au_core_fhir_version
      test from: :au_core_json_support
      test from: :au_core_xml_support

      test from: :au_core_profile_support do
        config(
          options: { au_core_resources: PROFILES.keys }
        )
      end
    end
  end
end
