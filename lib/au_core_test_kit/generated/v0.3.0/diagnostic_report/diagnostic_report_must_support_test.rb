require_relative '../../../must_support_test'

module AUCoreTestKit
  module AUCoreV030
    class DiagnosticReportMustSupportTest < Inferno::Test
      include AUCoreTestKit::MustSupportTest

      title 'All must support elements are provided in the DiagnosticReport resources returned'
      description %(
        AU Core Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the AU Core Server Capability
        Statement. This test will look through the DiagnosticReport resources
        found previously for the following must support elements:

false
      )

      id :au_core_v030_diagnostic_report_must_support_test

      def resource_type
        'DiagnosticReport'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:diagnostic_report_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
