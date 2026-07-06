# frozen_string_literal: true

require 'base64'
require 'inferno/dsl/oauth_credentials'
require 'inferno_suite_generator/utils/helpers'
require_relative '../../version'
require_relative '../../custom_groups/v0.3.0-ballot/capability_statement_group'
require_relative '../../custom_groups/missing_data_group'

require_relative 'patient_group'
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
require_relative 'allergy_intolerance_group'
require_relative 'composition_group'
require_relative 'condition_group'
require_relative 'diagnostic_report_group'
require_relative 'document_reference_group'
require_relative 'encounter_group'
require_relative 'immunization_group'
require_relative 'medication_request_group'
require_relative 'medication_dispense_group'
require_relative 'medication_statement_group'
require_relative 'procedure_group'
require_relative 'related_person_group'
require_relative 'endpoint_group'
require_relative 'healthcare_service_group'
require_relative 'location_group'
require_relative 'organization_group'
require_relative 'practitioner_group'
require_relative 'practitioner_role_group'

module AUCoreTestKit
  module AUCoreV210_DRAFT
    class AUCoreTestSuite < Inferno::TestSuite
      title 'AU Core v2.1.0-draft'
      description %(
        The AU Core Test Kit tests systems for their conformance to the [AU Core Implementation Guide](https://hl7.org.au/fhir/core/2.1.0-draft/index.html).

        HL7® FHIR® resources are validated with the Java validator using
        https://tx.dev.hl7.org.au/fhir as the terminology server.

        The test suite is generated using the [InfernoSuiteGenerator](https://github.com/hl7au/inferno_suite_generator) gem version 0.1.1.
      )
      version VERSION

      VERSION_SPECIFIC_MESSAGE_FILTERS = [].freeze

      def self.metadata
        @metadata ||= YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true)[:groups].map do |raw_metadata|
          Generator::GroupMetadata.new(raw_metadata)
        end
      end

      fhir_resource_validator do
        igs 'hl7.fhir.au.core#2.1.0-draft'
        message_filters = [
          "The value provided ('xml') was not found in the value set 'MimeType'",
          "The value provided ('json') was not found in the value set 'MimeType'",
          "The value provided ('ttl') was not found in the value set 'MimeType'"
        ] + VERSION_SPECIFIC_MESSAGE_FILTERS

        cli_context do
          txServer ENV.fetch('TX_SERVER_URL', 'https://tx.dev.hl7.org.au/fhir')
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

      id :au_core_v210_draft

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
        id :au_core_v210_draft_fhir_api

        group from: :au_core_v030_ballot_capability_statement

        group from: :au_core_v210_draft_patient

        group from: :au_core_v210_draft_bodyweight

        group from: :au_core_v210_draft_bloodpressure

        group from: :au_core_v210_draft_bodyheight

        group from: :au_core_v210_draft_diagnosticresult_path

        group from: :au_core_v210_draft_bodytemp

        group from: :au_core_v210_draft_heartrate

        group from: :au_core_v210_draft_waistcircum

        group from: :au_core_v210_draft_resprate

        group from: :au_core_v210_draft_diagnosticresult

        group from: :au_core_v210_draft_smokingstatus

        group from: :au_core_v210_draft_allergy_intolerance

        group from: :au_core_v210_draft_composition

        group from: :au_core_v210_draft_condition

        group from: :au_core_v210_draft_diagnostic_report

        group from: :au_core_v210_draft_document_reference

        group from: :au_core_v210_draft_encounter

        group from: :au_core_v210_draft_immunization

        group from: :au_core_v210_draft_medication_request

        group from: :au_core_v210_draft_medication_dispense

        group from: :au_core_v210_draft_medication_statement

        group from: :au_core_v210_draft_procedure

        group from: :au_core_v210_draft_related_person

        group from: :au_core_v210_draft_endpoint

        group from: :au_core_v210_draft_healthcare_service

        group from: :au_core_v210_draft_location

        group from: :au_core_v210_draft_organization

        group from: :au_core_v210_draft_practitioner

        group from: :au_core_v210_draft_practitioner_role

        group from: :au_core_missing_data_group
      end
    end
  end
end
