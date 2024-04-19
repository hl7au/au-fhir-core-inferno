require_relative '../../../must_support_test'

module AUCoreTestKit
  module AUCoreV040_CI_BUILD
    class AllergyIntoleranceMustSupportTest < Inferno::Test
      include AUCoreTestKit::MustSupportTest

      title 'All must support elements are provided in the AllergyIntolerance resources returned'
      description %(
        AU Core Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the AU Core Server Capability
        Statement. This test will look through the AllergyIntolerance resources
        found previously for the following must support elements:

        * AllergyIntolerance.asserter
        * AllergyIntolerance.clinicalStatus
        * AllergyIntolerance.code
        * AllergyIntolerance.encounter
        * AllergyIntolerance.note
        * AllergyIntolerance.onset[x]
        * AllergyIntolerance.patient
        * AllergyIntolerance.reaction
        * AllergyIntolerance.reaction.manifestation
        * AllergyIntolerance.reaction.severity
        * AllergyIntolerance.recorder
        * AllergyIntolerance.verificationStatus
      )

      id :au_core_v040_ci_build_allergy_intolerance_must_support_test

      def resource_type
        'AllergyIntolerance'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:allergy_intolerance_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
