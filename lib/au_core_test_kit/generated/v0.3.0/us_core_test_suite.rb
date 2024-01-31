require 'inferno/dsl/oauth_credentials'
require_relative '../../version'
require_relative '../../custom_groups/v0.3.0/capability_statement_group'
require_relative '../../custom_groups/v4.0.0/clinical_notes_guidance_group'
require_relative '../../custom_groups/data_absent_reason_group'
require_relative '../../custom_groups/smart_app_launch_group'
require_relative '../../provenance_validator'
require_relative '../../us_core_options'

require_relative 'patient_group'
require_relative 'au_core_bmi_group'
require_relative 'au_core_bodyweight_group'
require_relative 'au_core_oxygensat_group'
require_relative 'au_core_bloodpressure_group'
require_relative 'au_core_bodyheight_group'
require_relative 'au_core_diagnosticresult_path_group'
require_relative 'au_core_lipid_result_group'
require_relative 'au_core_headcircum_group'
require_relative 'au_core_bodytemp_group'
require_relative 'au_core_heartrate_group'
require_relative 'au_core_waistcircum_group'
require_relative 'au_core_vitalspanel_group'
require_relative 'au_core_resprate_group'
require_relative 'au_core_diagnosticresult_imag_group'
require_relative 'au_core_diagnosticresult_group'
require_relative 'au_core_sexassignedatbirth_group'
require_relative 'au_core_smokingstatus_group'
require_relative 'allergy_intolerance_group'
require_relative 'au_core_condition_group'
require_relative 'au_core_diagnostic_report_group'
require_relative 'document_reference_group'
require_relative 'encounter_group'
require_relative 'immunization_group'
require_relative 'medication_request_group'
require_relative 'medication_statement_group'
require_relative 'au_core_observation_group'
require_relative 'patient_group'
require_relative 'procedure_group'
require_relative 'service_request_group'
require_relative 'healthcare_service_group'
require_relative 'organization_group'
require_relative 'practitioner_group'
require_relative 'provenance_group'

module USCoreTestKit
  module USCoreV030
    class USCoreTestSuite < Inferno::TestSuite
      title 'US Core v0.3.0'
      description %(
        The US Core Test Kit tests systems for their conformance to the [US Core
        Implementation Guide]().

        HL7® FHIR® resources are validated with the Java validator using
        `tx.fhir.org` as the terminology server. Users should note that the
        although the ONC Certification (g)(10) Standardized API Test Suite
        includes tests from this suite, [it uses a different method to perform
        terminology
        validation](https://github.com/onc-healthit/onc-certification-g10-test-kit/wiki/FAQ#q-why-do-some-resources-fail-in-us-core-test-kit-with-terminology-validation-errors).
        As a result, resource validation results may not be consistent between
        the US Core Test Suite and the ONC Certification (g)(10) Standardized
        API Test Suite.
      )
      version VERSION

      VALIDATION_MESSAGE_FILTERS = [
        %r{Sub-extension url 'introspect' is not defined by the Extension http://fhir-registry\.smarthealthit\.org/StructureDefinition/oauth-uris},
        %r{Sub-extension url 'revoke' is not defined by the Extension http://fhir-registry\.smarthealthit\.org/StructureDefinition/oauth-uris},
        /Observation\.effective\.ofType\(Period\): .*vs-1:/, # Invalid invariant in FHIR v4.0.1
        /Observation\.effective\.ofType\(Period\): .*us-core-1:/, # Invalid invariant in US Core v3.1.1
        /Provenance.agent\[\d*\]: Rule provenance-1/, #Invalid invariant in US Core v5.0.1
        %r{Unknown Code System 'http://hl7.org/fhir/us/core/CodeSystem/us-core-tags'}, # Validator has an issue with this US Core 5 code system in US Core 6 resource
        %r{URL value 'http://hl7.org/fhir/us/core/CodeSystem/us-core-tags' does not resolve} # Validator has an issue with this US Core 5 code system in US Core 6 resource
      ].freeze

      VERSION_SPECIFIC_MESSAGE_FILTERS = [].freeze

      def self.metadata
        @metadata ||= YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true)[:groups].map do |raw_metadata|
            Generator::GroupMetadata.new(raw_metadata)
          end
      end

      validator do
        url ENV.fetch('V030_VALIDATOR_URL', 'http://validator_service:4567')
        message_filters = VALIDATION_MESSAGE_FILTERS + VERSION_SPECIFIC_MESSAGE_FILTERS

        exclude_message do |message|

          message_filters.any? { |filter| filter.match? message.message }
        end

        perform_additional_validation do |resource, profile_url|
          ProvenanceValidator.validate(resource) if resource.instance_of?(FHIR::Provenance)
        end
      end

      id :us_core_v030

      input :url,
        title: 'FHIR Endpoint',
        description: 'URL of the FHIR endpoint'
      input :smart_credentials,
        title: 'OAuth Credentials',
        type: :oauth_credentials,
        optional: true

      fhir_client do
        url :url
        oauth_credentials :smart_credentials
      end


      suite_option :smart_app_launch_version,
        title: 'SMART App Launch Version',
        list_options: [
          {
            label: 'SMART App Launch 1.0.0',
            value: USCoreOptions::SMART_1
          },
          {
            label: 'SMART App Launch 2.0.0',
            value: USCoreOptions::SMART_2
          }
        ]

      group from: :us_core_smart_app_launch

      group do
        title 'US Core FHIR API'
        id :us_core_v030_fhir_api

        group from: :us_core_v030_capability_statement
      
        group from: :us_core_v030_patient
        group from: :us_core_v030_au_core_bmi
        group from: :us_core_v030_au_core_bodyweight
        group from: :us_core_v030_au_core_oxygensat
        group from: :us_core_v030_au_core_bloodpressure
        group from: :us_core_v030_au_core_bodyheight
        group from: :us_core_v030_au_core_diagnosticresult_path
        group from: :us_core_v030_au_core_lipid_result
        group from: :us_core_v030_au_core_headcircum
        group from: :us_core_v030_au_core_bodytemp
        group from: :us_core_v030_au_core_heartrate
        group from: :us_core_v030_au_core_waistcircum
        group from: :us_core_v030_au_core_vitalspanel
        group from: :us_core_v030_au_core_resprate
        group from: :us_core_v030_au_core_diagnosticresult_imag
        group from: :us_core_v030_au_core_diagnosticresult
        group from: :us_core_v030_au_core_sexassignedatbirth
        group from: :us_core_v030_au_core_smokingstatus
        group from: :us_core_v030_allergy_intolerance
        group from: :us_core_v030_au_core_condition
        group from: :us_core_v030_au_core_diagnostic_report
        group from: :us_core_v030_document_reference
        group from: :us_core_v030_encounter
        group from: :us_core_v030_immunization
        group from: :us_core_v030_medication_request
        group from: :us_core_v030_medication_statement
        group from: :us_core_v030_au_core_observation
        group from: :us_core_v030_patient
        group from: :us_core_v030_procedure
        group from: :us_core_v030_service_request
        group from: :us_core_v030_healthcare_service
        group from: :us_core_v030_organization
        group from: :us_core_v030_practitioner
        group from: :us_core_v030_provenance
        group from: :us_core_v400_clinical_notes_guidance
        group from: :us_core_311_data_absent_reason
      end
    end
  end
end
