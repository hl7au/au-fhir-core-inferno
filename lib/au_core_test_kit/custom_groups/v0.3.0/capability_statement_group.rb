require 'tls_test_kit'
require_relative '../capability_statement/conformance_support_test'
require_relative '../capability_statement/fhir_version_test'
require_relative '../capability_statement/json_support_test'
require_relative './profile_support_test'

module AUCoreTestKit
  module AUCoreV311
    class CapabilityStatementGroup < Inferno::TestGroup
      id :au_core_v030_capability_statement
      title 'Capability Statement'
      short_description 'Retrieve information about supported server functionality using the FHIR capabilties interaction.'
      description %(
        # Background
        The #{title} Sequence tests a FHIR server's ability to formally describe
        features supported by the API by using the [Capability
        Statement](https://www.hl7.org/fhir/capabilitystatement.html) resource.
        The features described in the Capability Statement must be consistent with
        the required capabilities of a AU Core server. The Capability Statement
        must also advertise the location of the required SMART on FHIR endpoints
        that enable authenticated access to the FHIR server resources.

        The Capability Statement resource allows clients to determine which
        resources are supported by a FHIR Server. Not all servers are expected to
        implement all possible queries and data elements described in the AU Core
        API. For example, the AU Core Implementation Guide requires that the
        Patient resource and only one additional resource profile from the AU Core
        Profiles.

        # Test Methodology

        This test sequence accesses the server endpoint at `/metadata` using a
        `GET` request. It parses the Capability Statement and verifies that:

        * The endpoint is secured by an appropriate cryptographic protocol
        * The resource matches the expected FHIR version defined by the tests
        * The resource is a valid FHIR resource
        * The server claims support for JSON encoding of resources
        * The server claims support for the Patient resource and one other
          resource

        It collects the following information that is saved in the testing session
        for use by later tests:

        * List of resources supported
        * List of queries parameters supported
      )
      run_as_group

      PROFILES = {
        'AllergyIntolerance' => ['http://hl7.org.au/fhir/core/StructureDefinition/au-core-allergyintolerance'],
        'Condition' => ['http://hl7.org.au/fhir/core/StructureDefinition/au-core-condition'],
        'DiagnosticReport' => ['http://hl7.org.au/fhir/core/StructureDefinition/au-core-diagnosticreport'],
        'DocumentReference' => ['http://hl7.org.au/fhir/core/StructureDefinition/au-core-documentreference'],
        'Encounter' => ['http://hl7.org.au/fhir/core/StructureDefinition/au-core-encounter',],
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
                          'http://hl7.org.au/fhir/core/StructureDefinition/au-core-waistcircum',
        ].freeze,
        'Organization' => ['http://hl7.org.au/fhir/core/StructureDefinition/au-core-organization'],
        'Patient' => ['http://hl7.org.au/fhir/core/StructureDefinition/au-core-patient'],
        'Practitioner' => ['http://hl7.org.au/fhir/core/StructureDefinition/au-core-practitioner'],
        'PractitionerRole' => ['http://hl7.org.au/fhir/core/StructureDefinition/au-core-practitionerrole'],
        'Procedure' => ['http://hl7.org.au/fhir/core/StructureDefinition/au-core-procedure'],
        'Provenance' => ['http://hl7.org.au/fhir/core/StructureDefinition/au-core-provenance'],
        'ServiceRequest' => ['http://hl7.org.au/fhir/core/StructureDefinition/au-core-servicerequest'],
      }.freeze

      test from: :tls_version_test,
          id: :standalone_auth_tls,
          title: 'FHIR server secured by transport layer security',
          description: %(
            Systems **SHALL** use TLS version 1.2 or higher for all transmissions
            not taking place over a secure network connection.
          ),
          config: {
            options: {  minimum_allowed_version: OpenSSL::SSL::TLS1_2_VERSION }
          }
      test from: :au_core_conformance_support
      test from: :au_core_fhir_version
      test from: :au_core_json_support

      test from: :au_core_profile_support do
        config(
          options: { au_core_resources: PROFILES.keys }
        )
      end
    end
  end
end
