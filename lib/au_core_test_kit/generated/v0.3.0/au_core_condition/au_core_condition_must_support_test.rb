require_relative '../../../must_support_test'

module USCoreTestKit
  module USCoreV030
    class AuCoreConditionMustSupportTest < Inferno::Test
      include USCoreTestKit::MustSupportTest

      title 'All must support elements are provided in the Condition resources returned'
      description %(
        US Core Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the US Core Server Capability
        Statement. This test will look through the Condition resources
        found previously for the following must support elements:

false
      )

      id :us_core_v030_au_core_condition_must_support_test

      def resource_type
        'Condition'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:au_core_condition_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
