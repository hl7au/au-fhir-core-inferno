require_relative '../../../must_support_test'

module AUCoreTestKit
  module AUCoreV040_CI_BUILD
    class PractitionerMustSupportTest < Inferno::Test
      include AUCoreTestKit::MustSupportTest

      title 'All must support elements are provided in the Practitioner resources returned'
      description %(
        AU Core Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the AU Core Server Capability
        Statement. This test will look through the Practitioner resources
        found previously for the following must support elements:

        * Practitioner.address
        * Practitioner.communication
        * Practitioner.identifier
        * Practitioner.name
        * Practitioner.qualification
        * Practitioner.qualification.code
        * Practitioner.qualification.identifier
        * Practitioner.qualification.issuer
        * Practitioner.qualification.period
        * Practitioner.telecom
      )

      id :au_core_v040_ci_build_practitioner_must_support_test

      def resource_type
        'Practitioner'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:practitioner_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
