# frozen_string_literal: true

require 'base64'
require 'inferno/dsl/oauth_credentials'
require 'inferno_suite_generator/utils/helpers'
require_relative '../../version'

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
require_relative 'condition_group'
require_relative 'encounter_group'
require_relative 'immunization_group'
require_relative 'medication_request_group'
require_relative 'medication_statement_group'
require_relative 'procedure_group'
require_relative 'related_person_group'
require_relative 'healthcare_service_group'
require_relative 'location_group'
require_relative 'organization_group'
require_relative 'practitioner_group'
require_relative 'practitioner_role_group'

module AUCoreTestKit
  module AUCoreV200
    class AUCoreTestSuite < Inferno::TestSuite
      title 'AU Core v2.0.0'
      description %(
        The AU Core Test Kit tests systems for their conformance to the [AU Core Implementation Guide](https://hl7.org.au/fhir/core/2.0.0/index.html).

        HL7® FHIR® resources are validated with the Java validator using
        https://tx.dev.hl7.org.au/fhir as the terminology server.

        The test suite is generated using the [InfernoSuiteGenerator](https://github.com/hl7au/inferno_suite_generator) gem version 0.1.0.
      )
      version VERSION

      VERSION_SPECIFIC_MESSAGE_FILTERS = [].freeze

      def self.metadata
        @metadata ||= YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true)[:groups].map do |raw_metadata|
          Generator::GroupMetadata.new(raw_metadata)
        end
      end

      fhir_resource_validator do
        igs '/home/igs/2.0.0.tgz'
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

      id :au_core_v200

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
        id :au_core_v200_fhir_api

        group from: :au_core_v200_patient

        group from: :au_core_v200_bodyweight

        group from: :au_core_v200_bloodpressure

        group from: :au_core_v200_bodyheight

        group from: :au_core_v200_diagnosticresult_path

        group from: :au_core_v200_bodytemp

        group from: :au_core_v200_heartrate

        group from: :au_core_v200_waistcircum

        group from: :au_core_v200_resprate

        group from: :au_core_v200_diagnosticresult

        group from: :au_core_v200_smokingstatus

        group from: :au_core_v200_allergy_intolerance

        group from: :au_core_v200_condition

        group from: :au_core_v200_encounter

        group from: :au_core_v200_immunization

        group from: :au_core_v200_medication_request

        group from: :au_core_v200_medication_statement

        group from: :au_core_v200_procedure

        group from: :au_core_v200_related_person

        group from: :au_core_v200_healthcare_service

        group from: :au_core_v200_location

        group from: :au_core_v200_organization

        group from: :au_core_v200_practitioner

        group from: :au_core_v200_practitioner_role
      end
    end
  end
end
