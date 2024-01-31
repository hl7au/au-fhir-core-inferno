require 'tls_test_kit'
require_relative '../capability_statement/conformance_support_test'
require_relative '../capability_statement/fhir_version_test'
require_relative '../capability_statement/json_support_test'
require_relative '../capability_statement/profile_support_test'
require_relative '../capability_statement/instantiate_test'

module USCoreTestKit
  module USCoreV501
    class CapabilityStatementGroup < Inferno::TestGroup
      id :us_core_v501_capability_statement
      title 'Capability Statement'
      short_description 'Retrieve information about supported server functionality using the FHIR capabilties interaction.'
      description %(
        # Background
        The #{title} Sequence tests a FHIR server's ability to formally describe
        features supported by the API by using the [Capability
        Statement](https://www.hl7.org/fhir/capabilitystatement.html) resource.
        The features described in the Capability Statement must be consistent with
        the required capabilities of a US Core server. The Capability Statement
        must also advertise the location of the required SMART on FHIR endpoints
        that enable authenticated access to the FHIR server resources.

        The Capability Statement resource allows clients to determine which
        resources are supported by a FHIR Server. Not all servers are expected to
        implement all possible queries and data elements described in the US Core
        API. For example, the US Core Implementation Guide requires that the
        Patient resource and only one additional resource profile from the US Core
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
        'AllergyIntolerance' => ['http://hl7.org/fhir/us/core/StructureDefinition/us-core-allergyintolerance'].freeze,
        'CarePlan' => ['http://hl7.org/fhir/us/core/StructureDefinition/us-core-careplan'].freeze,
        'CareTeam' => ['http://hl7.org/fhir/us/core/StructureDefinition/us-core-careteam'].freeze,
        'Condition' => [
          'http://hl7.org/fhir/us/core/StructureDefinition/us-core-condition-encounter-diagnosis',
          'http://hl7.org/fhir/us/core/StructureDefinition/us-core-condition-problems-health-concerns'
        ].freeze,
        'Device' => ['http://hl7.org/fhir/us/core/StructureDefinition/us-core-implantable-device'].freeze,
        'DiagnosticReport' => [
          'http://hl7.org/fhir/us/core/StructureDefinition/us-core-diagnosticreport-lab',
          'http://hl7.org/fhir/us/core/StructureDefinition/us-core-diagnosticreport-note'
        ].freeze,
        'DocumentReference' => ['http://hl7.org/fhir/us/core/StructureDefinition/us-core-documentreference'].freeze,
        'Encounter' => ['http://hl7.org/fhir/us/core/StructureDefinition/us-core-encounter'].freeze,
        'Goal' => ['http://hl7.org/fhir/us/core/StructureDefinition/us-core-goal'].freeze,
        'Immunization' => ['http://hl7.org/fhir/us/core/StructureDefinition/us-core-immunization'].freeze,
        'Location' => ['http://hl7.org/fhir/us/core/StructureDefinition/us-core-location'].freeze,
        'Medication' => ['http://hl7.org/fhir/us/core/StructureDefinition/us-core-medication'].freeze,
        'MedicationRequest' => ['http://hl7.org/fhir/us/core/StructureDefinition/us-core-medicationrequest'].freeze,
        'Observation' => [
          'http://hl7.org/fhir/us/core/StructureDefinition/us-core-observation-lab',
          'http://hl7.org/fhir/us/core/StructureDefinition/us-core-vital-signs',
          'http://hl7.org/fhir/us/core/StructureDefinition/us-core-blood-pressure',
          'http://hl7.org/fhir/us/core/StructureDefinition/us-core-bmi',
          'http://hl7.org/fhir/us/core/StructureDefinition/us-core-head-circumference',
          'http://hl7.org/fhir/us/core/StructureDefinition/us-core-body-height',
          'http://hl7.org/fhir/us/core/StructureDefinition/us-core-body-weight',
          'http://hl7.org/fhir/us/core/StructureDefinition/us-core-body-temperature',
          'http://hl7.org/fhir/us/core/StructureDefinition/us-core-heart-rate',
          'http://hl7.org/fhir/us/core/StructureDefinition/pediatric-bmi-for-age',
          'http://hl7.org/fhir/us/core/StructureDefinition/head-occipital-frontal-circumference-percentile',
          'http://hl7.org/fhir/us/core/StructureDefinition/pediatric-weight-for-height',
          'http://hl7.org/fhir/us/core/StructureDefinition/us-core-pulse-oximetry',
          'http://hl7.org/fhir/us/core/StructureDefinition/us-core-respiratory-rate',
          'http://hl7.org/fhir/us/core/StructureDefinition/us-core-smokingstatus',
          'http://hl7.org/fhir/us/core/StructureDefinition/us-core-observation-clinical-test',
          'http://hl7.org/fhir/us/core/StructureDefinition/us-core-observation-imaging',
          'http://hl7.org/fhir/us/core/StructureDefinition/us-core-observation-sexual-orientation',
          'http://hl7.org/fhir/us/core/StructureDefinition/us-core-observation-social-history',
          'http://hl7.org/fhir/us/core/StructureDefinition/us-core-observation-survey',
          'http://hl7.org/fhir/us/core/StructureDefinition/us-core-observation-sdoh-assessment'
        ].freeze,
        'Organization' => ['http://hl7.org/fhir/us/core/StructureDefinition/us-core-organization'].freeze,
        'Patient' => ['http://hl7.org/fhir/us/core/StructureDefinition/us-core-patient'].freeze,
        'Practitioner' => ['http://hl7.org/fhir/us/core/StructureDefinition/us-core-practitioner'].freeze,
        'PractitionerRole' => ['http://hl7.org/fhir/us/core/StructureDefinition/us-core-practitionerrole'].freeze,
        'Procedure' => ['http://hl7.org/fhir/us/core/StructureDefinition/us-core-procedure'].freeze,
        'Provenance' => ['http://hl7.org/fhir/us/core/StructureDefinition/us-core-provenance'].freeze,
        'QuestionnaireResponse' => ['http://hl7.org/fhir/us/core/StructureDefinition/us-core-questionnaireresponse'].freeze,
        'RelatedPerson' => ['http://hl7.org/fhir/us/core/StructureDefinition/us-core-relatedperson'].freeze,
        'ServiceRequest' => ['http://hl7.org/fhir/us/core/StructureDefinition/us-core-servicerequest'].freeze
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
      test from: :us_core_conformance_support
      test from: :us_core_fhir_version
      test from: :us_core_json_support

      test from: :us_core_profile_support do
        config(
          options: { us_core_profiles: PROFILES.values.flatten }
        )
      end

      test from: :us_core_instantiate
    end
  end
end
