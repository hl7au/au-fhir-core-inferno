require 'base64'
require 'inferno/dsl/oauth_credentials'
require_relative '../../version'
require_relative '../../custom_groups/v0.3.0-ballot/capability_statement_group'
require_relative '../../custom_groups/smart_app_launch_group'
require_relative '../../au_core_options'
require_relative '../../helpers'

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
require_relative 'location_group'
require_relative 'organization_group'
require_relative 'practitioner_group'
require_relative 'practitioner_role_group'
require_relative 'provenance_group'

module AUCoreTestKit
  module AUCoreV030_BALLOT
    class AUCoreTestSuite < Inferno::TestSuite
      title 'AU Core v0.3.0-ballot'
      description %(
        The AU Core Test Kit tests systems for their conformance to the [AU Core
        Implementation Guide](http://hl7.org.au/fhir/core/0.3.0-ballot).

        HL7® FHIR® resources are validated with the Java validator using
        `#{ENV.fetch('TX_SERVER_URL', 'https://tx.dev.hl7.org.au/fhir')}` as the terminology server.
      )
      version VERSION

      VALIDATION_MESSAGE_FILTERS = [
        %r{Sub-extension url 'introspect' is not defined by the Extension http://fhir-registry\.smarthealthit\.org/StructureDefinition/oauth-uris},
        %r{Sub-extension url 'revoke' is not defined by the Extension http://fhir-registry\.smarthealthit\.org/StructureDefinition/oauth-uris},
        /Observation\.effective\.ofType\(Period\): .*vs-1:/, # Invalid invariant in FHIR v4.0.1
        /Observation\.effective\.ofType\(Period\): .*us-core-1:/, # Invalid invariant in AU Core v3.1.1
        /Provenance.agent\[\d*\]: Rule provenance-1/, #Invalid invariant in AU Core v5.0.1
      ].freeze

      VERSION_SPECIFIC_MESSAGE_FILTERS = [].freeze

      def self.metadata
        @metadata ||= YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true)[:groups].map do |raw_metadata|
            Generator::GroupMetadata.new(raw_metadata)
          end
      end

      validator do
        url ENV.fetch('V030_BALLOT_VALIDATOR_URL', 'http://validator-api:4567')
        message_filters = VALIDATION_MESSAGE_FILTERS + VERSION_SPECIFIC_MESSAGE_FILTERS

        exclude_message do |message|

          message_filters.any? { |filter| filter.match? message.message }
        end

        # perform_additional_validation do |resource, profile_url|
        #   ProvenanceValidator.validate(resource) if resource.instance_of?(FHIR::Provenance)
        # end
      end

      id :au_core_v030_ballot

      input :url,
        title: 'FHIR Endpoint',
        description: 'URL of the FHIR endpoint',
        default: 'https://sparked.npd.telstrahealth.com/smile/fhir/DEFAULT'
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
        id :au_core_v030_ballot_fhir_api

        group from: :au_core_v030_ballot_capability_statement
      
        group from: :au_core_v030_ballot_patient
      
        group from: :au_core_v030_ballot_bodyweight
      
        group from: :au_core_v030_ballot_bloodpressure
      
        group from: :au_core_v030_ballot_bodyheight
      
        group from: :au_core_v030_ballot_diagnosticresult_path
      
        group from: :au_core_v030_ballot_bodytemp
      
        group from: :au_core_v030_ballot_heartrate
      
        group from: :au_core_v030_ballot_waistcircum
      
        group from: :au_core_v030_ballot_resprate
      
        group from: :au_core_v030_ballot_diagnosticresult
      
        group from: :au_core_v030_ballot_smokingstatus
      
        group from: :au_core_v030_ballot_allergy_intolerance
      
        group from: :au_core_v030_ballot_condition
      
        group from: :au_core_v030_ballot_encounter
      
        group from: :au_core_v030_ballot_immunization
      
        group from: :au_core_v030_ballot_medication_request
      
        group from: :au_core_v030_ballot_medication_statement
      
        group from: :au_core_v030_ballot_procedure
      
        group from: :au_core_v030_ballot_location
      
        group from: :au_core_v030_ballot_organization
      
        group from: :au_core_v030_ballot_practitioner
      
        group from: :au_core_v030_ballot_practitioner_role
      
        group from: :au_core_v030_ballot_provenance
      
      end
    end
  end
end
