# frozen_string_literal: true

require 'inferno_suite_generator/test_modules/read_test'

module AUCoreTestKit
  module AUCoreV210_DRAFT
    class CompositionReadTest < Inferno::Test
      include InfernoSuiteGenerator::ReadTest

      title '(SHALL) Server returns correct Composition resource from Composition read interaction'
      description 'A server SHALL support the Composition read interaction.'

      id :au_core_v210_draft_composition_read_test

      def self.demodata
        @demodata ||= InfernoSuiteGenerator::Generator::IGDemodata.new(
          YAML.load_file(File.join(File.dirname(__dir__), 'demodata.yml'), aliases: true)
        )
      end

      def resource_type
        'Composition'
      end

      def scratch_resources
        scratch[:composition_resources] ||= {}
      end

      run do
        perform_read_test(all_scratch_resources)
      end
    end
  end
end
