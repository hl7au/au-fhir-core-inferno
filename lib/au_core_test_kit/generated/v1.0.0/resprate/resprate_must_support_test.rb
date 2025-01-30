# frozen_string_literal: true

require_relative '../../../must_support_test'

module AUCoreTestKit
  module AUCoreV100
    class ResprateMustSupportTest < Inferno::Test
      include AUCoreTestKit::MustSupportTest

      title 'All must support elements are provided in the Observation resources returned'
      description %(
        AU Core Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the AU Core Server Capability
        Statement. This test will look through the Observation resources
        found previously for the following must support elements:

        * Observation.category
        * Observation.category:VSCat
        * Observation.category:VSCat.coding
        * Observation.category:VSCat.coding.code
        * Observation.category:VSCat.coding.system
        * Observation.code
        * Observation.effective[x]
        * Observation.status
        * Observation.subject
        * Observation.value[x]
        * Observation.value[x]:valueQuantity
        * Observation.value[x]:valueQuantity.code
        * Observation.value[x]:valueQuantity.system
        * Observation.value[x]:valueQuantity.unit
        * Observation.value[x]:valueQuantity.value
      )

      id :au_core_v100_resprate_must_support_test

      def resource_type
        'Observation'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:resprate_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
