# frozen_string_literal: true

require 'inferno_suite_generator/test_modules/read_test'

module AUCoreTestKit
  module AUCoreV210_DRAFT
    class HealthcareServiceReadTest < Inferno::Test
      include InfernoSuiteGenerator::ReadTest

      title '(SHALL) Server returns correct HealthcareService resource from HealthcareService read interaction'
      description 'A server SHALL support the HealthcareService read interaction.'

      input :healthcare_service_ids,
            title: 'HealthcareService IDs',
            description: 'Comma separated list of healthcare service IDs that in sum contain all MUST SUPPORT elements',
            default: 'generalpractice-bungabbee-medical-clinic, communityhealth-southedge-practice, dentalpractice-annandale-dental, pathologylaboratory-woodcroft-pathology',
            optional: true

      id :au_core_v210_draft_healthcare_service_read_test

      def self.demodata
        @demodata ||= InfernoSuiteGenerator::Generator::IGDemodata.new(
          YAML.load_file(File.join(File.dirname(__dir__), 'demodata.yml'), aliases: true)
        )
      end

      def resource_type
        'HealthcareService'
      end

      def scratch_resources
        scratch[:healthcare_service_resources] ||= {}
      end

      run do
        perform_read_test(scratch.dig(:references, 'HealthcareService'))
      end
    end
  end
end
