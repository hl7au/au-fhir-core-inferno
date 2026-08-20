# frozen_string_literal: true

require 'base64'
require 'inferno/dsl/oauth_credentials'
require 'inferno_suite_generator/utils/helpers'
require 'inferno_suite_generator/utils/fhirpath_lab_message_linker'
require 'inferno_suite_generator/utils/resource_keeper_endpoints'
require_relative '../../version'
require_relative '../../custom_groups/v0.3.0-ballot/capability_statement_group'
require_relative '../../custom_groups/missing_data_group'

require_relative 'patient_group'
require_relative 'allergy_intolerance_group'
require_relative 'composition_group'
require_relative 'condition_group'
require_relative 'diagnostic_report_group'
require_relative 'document_reference_group'
require_relative 'encounter_group'
require_relative 'immunization_group'
require_relative 'medication_dispense_group'
require_relative 'medication_request_group'
require_relative 'medication_statement_group'
require_relative 'bodyweight_group'
require_relative 'bloodpressure_group'
require_relative 'bodyheight_group'
require_relative 'diagnosticresult_path_group'
require_relative 'bodytemp_group'
require_relative 'heartrate_group'
require_relative 'waistcircum_group'
require_relative 'resprate_group'
require_relative 'diagnosticresult_group'
require_relative 'smokingstatus_group'
require_relative 'procedure_group'
require_relative 'related_person_group'
require_relative 'endpoint_group'
require_relative 'healthcare_service_group'
require_relative 'location_group'
require_relative 'organization_group'
require_relative 'practitioner_group'
require_relative 'practitioner_role_group'

module AUCoreTestKit
  module AUCoreV300_BALLOT1
    class AUCoreTestSuite < Inferno::TestSuite
      title 'AU Core v3.0.0-ballot1'
      description %(
        The AU Core Test Kit tests systems for their conformance to the [AU Core Implementation Guide](https://hl7.org.au/fhir/core/3.0.0-ballot1/index.html).

        HL7® FHIR® resources are validated with the Java validator using
        https://tx.dev.hl7.org.au/fhir as the terminology server.

        The test suite is generated using the [InfernoSuiteGenerator](https://github.com/hl7au/inferno_suite_generator) gem version 0.1.0.
      )
      version VERSION

      # `id` MUST be declared before `fhir_resource_validator`. The validator captures the
      # suite id eagerly as its `test_suite_id`, and Inferno keys validator sessions on it.
      # If `id` comes after, the capture falls back to the base-class name
      # "Inferno::Entities::TestSuite", which every affected suite then shares as a single
      # validator session, collapsing separate IG versions onto one validator engine and
      # causing intermittent "Unable to resolve profile ...|<version>" errors.
      id :au_core_v300_ballot1

      VERSION_SPECIFIC_MESSAGE_FILTERS = [].freeze

      # Base URL of a FHIRPath Lab instance (https://fhirpath-lab.com/) used to turn FHIRPath
      # locations in validation messages into links testers can use to interactively debug the
      # failing expression. FHIRPath Lab fetches the resource content from this suite's own
      # /custom/<suite_id>/resources/... endpoint (see resource_keeper_endpoints.rb).
      FHIRPATHLAB_URL = ENV.fetch('FHIRPATHLAB_URL', 'https://fhirpath-lab.com/FhirPath').presence

      suite_endpoint :post, '/resources/:session_id/:resource_type/:resource_id',
                     InfernoSuiteGenerator::SaveResourceEndpoint
      suite_endpoint :get, '/resources/:session_id/:resource_type/:resource_id',
                     InfernoSuiteGenerator::FetchResourceEndpoint
      suite_endpoint :delete, '/resources/:session_id',
                     InfernoSuiteGenerator::DeleteSessionResourcesEndpoint

      def self.metadata
        @metadata ||= YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true)[:groups].map do |raw_metadata|
          Generator::GroupMetadata.new(raw_metadata)
        end
      end

      fhir_resource_validator do
        igs 'hl7.fhir.au.core#3.0.0-ballot1'
        message_filters = [
          "The value provided ('xml') was not found in the value set 'MimeType'",
          "The value provided ('json') was not found in the value set 'MimeType'",
          "The value provided ('ttl') was not found in the value set 'MimeType'"
        ] + VERSION_SPECIFIC_MESSAGE_FILTERS

        cli_context do
          txServer ENV.fetch('TX_SERVER_URL', 'https://tx.dev.hl7.org.au/fhir')
          snomedCT ENV.fetch('SNOMED_EDITION', 'au')
          disableDefaultResourceFetcher false
        end

        exclude_message do |message|
          Helpers.is_message_exist_in_list(message_filters, message.message)
        end

        perform_additional_validation do |resource, _profile_url|
          ProvenanceValidator.validate(resource) if resource.instance_of?(FHIR::Provenance)
        end
      end

      links [
        {
          label: 'Report Issue',
          url: 'https://github.com/hl7au/au-fhir-core-inferno/issues'
        },
        {
          label: 'Source Code',
          url: 'https://github.com/hl7au/au-fhir-core-inferno'
        },
        {
          label: 'Implementation Guide',
          url: 'https://build.fhir.org/ig/hl7au/au-fhir-core/index.html'
        }
      ]

      input :url,
            title: 'FHIR Endpoint',
            description: 'URL of the FHIR endpoint',
            default: 'https://fhir.hl7.org.au/aucore/fhir/DEFAULT'
      input :smart_credentials,
            title: 'OAuth Credentials',
            type: :oauth_credentials,
            optional: true
      input :header_name,
            title: 'Header name',
            optional: true
      input :header_value,
            title: 'Header value',
            optional: true

      fhir_client do
        url :url
        oauth_credentials :smart_credentials
        headers Helpers.get_http_header(header_name, header_value)
      end

      group do
        title 'AU Core FHIR API'
        id :au_core_v300_ballot1_fhir_api

        group from: :au_core_v030_ballot_capability_statement

        group from: :au_core_v300_ballot1_patient

        group from: :au_core_v300_ballot1_allergy_intolerance

        group from: :au_core_v300_ballot1_composition

        group from: :au_core_v300_ballot1_condition

        group from: :au_core_v300_ballot1_diagnostic_report

        group from: :au_core_v300_ballot1_document_reference

        group from: :au_core_v300_ballot1_encounter

        group from: :au_core_v300_ballot1_immunization

        group from: :au_core_v300_ballot1_medication_dispense

        group from: :au_core_v300_ballot1_medication_request

        group from: :au_core_v300_ballot1_medication_statement

        group from: :au_core_v300_ballot1_bodyweight

        group from: :au_core_v300_ballot1_bloodpressure

        group from: :au_core_v300_ballot1_bodyheight

        group from: :au_core_v300_ballot1_diagnosticresult_path

        group from: :au_core_v300_ballot1_bodytemp

        group from: :au_core_v300_ballot1_heartrate

        group from: :au_core_v300_ballot1_waistcircum

        group from: :au_core_v300_ballot1_resprate

        group from: :au_core_v300_ballot1_diagnosticresult

        group from: :au_core_v300_ballot1_smokingstatus

        group from: :au_core_v300_ballot1_procedure

        group from: :au_core_v300_ballot1_related_person

        group from: :au_core_v300_ballot1_endpoint

        group from: :au_core_v300_ballot1_healthcare_service

        group from: :au_core_v300_ballot1_location

        group from: :au_core_v300_ballot1_organization

        group from: :au_core_v300_ballot1_practitioner

        group from: :au_core_v300_ballot1_practitioner_role

        group from: :au_core_missing_data_group
      end
    end
  end
end
