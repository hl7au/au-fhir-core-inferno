# frozen_string_literal: true

require_relative '../../../must_support_test'

module AUCoreTestKit
  module AUCoreV040_CI_BUILD
    class PatientMustSupportTest < Inferno::Test
      include AUCoreTestKit::MustSupportTest

      title 'All must support elements are provided in the Patient resources returned'
      description %(
        AU Core Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the AU Core Server Capability
        Statement. This test will look through the Patient resources
        found previously for the following must support elements:

        * Patient.address
        * Patient.birthDate
        * Patient.birthDate.extension:accuracyIndicator
        * Patient.birthDate.extension:birthTime
        * Patient.communication
        * Patient.communication.language
        * Patient.communication.preferred
        * Patient.extension:birthPlace
        * Patient.extension:genderIdentity
        * Patient.extension:indigenousStatus
        * Patient.extension:individualPronouns
        * Patient.extension:interpreterRequired
        * Patient.gender
        * Patient.identifier
        * Patient.name
        * Patient.name.use
        * Patient.telecom
      )

      id :au_core_v040_ci_build_patient_must_support_test

      def resource_type
        'Patient'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:patient_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
