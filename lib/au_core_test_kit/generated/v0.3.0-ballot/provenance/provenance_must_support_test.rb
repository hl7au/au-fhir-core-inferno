# frozen_string_literal: true

require_relative '../../../must_support_test'

module AUCoreTestKit
  module AUCoreV030_BALLOT
    class ProvenanceMustSupportTest < Inferno::Test
      include AUCoreTestKit::MustSupportTest

      title 'All must support elements are provided in the Provenance resources returned'
      description %(
        AU Core Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the AU Core Server Capability
        Statement. This test will look through the Provenance resources
        found previously for the following must support elements:

        * Provenance.activity
        * Provenance.agent
        * Provenance.agent.onBehalfOf
        * Provenance.agent.who
        * Provenance.occurred[x]
        * Provenance.recorded
        * Provenance.target
      )

      id :au_core_v030_ballot_provenance_must_support_test

      def resource_type
        'Provenance'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:provenance_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
