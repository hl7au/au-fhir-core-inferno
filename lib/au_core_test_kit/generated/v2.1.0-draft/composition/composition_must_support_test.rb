# frozen_string_literal: true

require 'inferno_suite_generator/test_modules/must_support_test'

module AUCoreTestKit
  module AUCoreV210_DRAFT
    class CompositionMustSupportTest < Inferno::Test
      include InfernoSuiteGenerator::MustSupportTest

      title 'All must support elements are provided in the Composition resources returned'
      description %(
        AU Core Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the AU Core Server Capability
        Statement. This test will look through the Composition resources
        found previously for the following must support elements:

        * Composition.attester
        * Composition.attester.mode
        * Composition.attester.party
        * Composition.attester.time
        * Composition.author
        * Composition.custodian
        * Composition.date
        * Composition.identifier
        * Composition.section
        * Composition.section.code
        * Composition.section.text
        * Composition.section.title
        * Composition.status
        * Composition.subject
        * Composition.text
        * Composition.title
        * Composition.type
      )

      id :au_core_v210_draft_composition_must_support_test

      def resource_type
        'Composition'
      end

      def self.metadata
        @metadata ||= InfernoSuiteGenerator::Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:composition_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
