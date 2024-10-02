# frozen_string_literal: true

require 'base64'
require 'inferno/dsl/oauth_credentials'
require_relative '../../version'
require_relative '../../custom_groups/v0.3.0-ballot/capability_statement_group'
require_relative '../../custom_groups/smart_app_launch_group'
require_relative '../../custom_groups/missing_data_group'
require_relative '../../au_core_options'
require_relative '../../helpers'
require_relative '../../constants'

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
require_relative 'procedure_group'
require_relative 'location_group'
require_relative 'organization_group'
require_relative 'practitioner_group'
require_relative 'practitioner_role_group'

module AUCoreTestKit
  module AUCoreV041_PREVIEW
    class AUCoreTestSuite < Inferno::TestSuite
      title 'AU Core v0.4.1-preview'
      description %(
        The AU Core Test Kit tests systems for their conformance to the [AU Core
        Implementation Guide]().

        HL7® FHIR® resources are validated with the Java validator using
        `#{ENV.fetch('TX_SERVER_URL', 'https://tx.dev.hl7.org.au/fhir')}` as the terminology server.
      )
      version VERSION

      VERSION_SPECIFIC_MESSAGE_FILTERS = [].freeze

      def self.metadata
        @metadata ||= YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true)[:groups].map do |raw_metadata|
          Generator::GroupMetadata.new(raw_metadata)
        end
      end

      fhir_resource_validator do
        igs 'hl7.fhir.au.core#0.4.1-preview'
        message_filters = Constants.validation_message_filters + VERSION_SPECIFIC_MESSAGE_FILTERS

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
          label: 'Open Source',
          url: 'https://github.com/hl7au/au-fhir-core-inferno'
        },
        {
          label: 'AU Core Implementation Guide',
          url: 'https://build.fhir.org/ig/hl7au/au-fhir-core/'
        }
      ]

      id :au_core_v041_preview

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
        id :au_core_v041_preview_fhir_api

        group from: :au_core_v030_ballot_capability_statement

        group from: :au_core_v041_preview_patient

        group from: :au_core_v041_preview_bodyweight

        group from: :au_core_v041_preview_bloodpressure

        group from: :au_core_v041_preview_bodyheight

        group from: :au_core_v041_preview_diagnosticresult_path

        group from: :au_core_v041_preview_bodytemp

        group from: :au_core_v041_preview_heartrate

        group from: :au_core_v041_preview_waistcircum

        group from: :au_core_v041_preview_resprate

        group from: :au_core_v041_preview_diagnosticresult

        group from: :au_core_v041_preview_smokingstatus

        group from: :au_core_v041_preview_allergy_intolerance

        group from: :au_core_v041_preview_condition

        group from: :au_core_v041_preview_encounter

        group from: :au_core_v041_preview_immunization

        group from: :au_core_v041_preview_medication_request

        group from: :au_core_v041_preview_procedure

        group from: :au_core_v041_preview_location

        group from: :au_core_v041_preview_organization

        group from: :au_core_v041_preview_practitioner

        group from: :au_core_v041_preview_practitioner_role

        group from: :au_core_missing_data_group
      end
    end
  end
end
