# frozen_string_literal: true

require 'validation_test_kit/validation_test'

module AUCoreTestKit
  module AUCoreValidationSuite
    class AUCoreTestSuite < Inferno::TestSuite
      id :validations
      title 'Validation Test Suite'
      description 'Validation Test Suite'
      VALIDATION_MESSAGE_FILTERS = [
        %r{Sub-extension url 'introspect' is not defined by the Extension http://fhir-registry\.smarthealthit\.org/StructureDefinition/oauth-uris},
        %r{Sub-extension url 'revoke' is not defined by the Extension http://fhir-registry\.smarthealthit\.org/StructureDefinition/oauth-uris},
        /Observation\.effective\.ofType\(Period\): .*vs-1:/, # Invalid invariant in FHIR v4.0.1
        /Observation\.effective\.ofType\(Period\): .*us-core-1:/, # Invalid invariant in AU Core v3.1.1
        /Provenance.agent\[\d*\]: Rule provenance-1/, # Invalid invariant in AU Core v5.0.1
        /\A\S+: \S+: URL value '.*' does not resolve/
      ].freeze

      VERSION_SPECIFIC_MESSAGE_FILTERS = [].freeze

      def self.metadata
        @metadata ||= YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true)[:groups].map do |raw_metadata|
          Generator::GroupMetadata.new(raw_metadata)
        end
      end

      fhir_resource_validator do
        igs 'hl7.fhir.au.core#1.0.0-ballot'
        message_filters = VALIDATION_MESSAGE_FILTERS + VERSION_SPECIFIC_MESSAGE_FILTERS

        cli_context do
          txServer ENV.fetch('TX_SERVER_URL', 'https://tx.dev.hl7.org.au/fhir')
          disableDefaultResourceFetcher false
        end

        exclude_message do |message|
          message_filters.any? { |filter| filter.match? message.message }
        end
      end

      group do
        title 'Validation of any FHIR resource'
        test from: :validation_test,
             config: {
               options: {
                 ig_version: '1.0.0-ballot'
               }
             }
      end
    end
  end
end
