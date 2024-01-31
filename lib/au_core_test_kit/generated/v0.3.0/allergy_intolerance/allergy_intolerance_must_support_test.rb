require_relative '../../../must_support_test'

module AUCoreTestKit
  module AUCoreV030
    class AllergyIntoleranceMustSupportTest < Inferno::Test
      include AUCoreTestKit::MustSupportTest

      title 'All must support elements are provided in the AllergyIntolerance resources returned'
      description %(
        AU Core Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the AU Core Server Capability
        Statement. This test will look through the AllergyIntolerance resources
        found previously for the following must support elements:

false
      )

      id :au_core_v030_allergy_intolerance_must_support_test

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
