require_relative '../../../read_test'

module AUCoreTestKit
  module AUCoreV030
    class DiagnosticReportReadTest < Inferno::Test
      include AUCoreTestKit::ReadTest

      title 'Server returns correct DiagnosticReport resource from DiagnosticReport read interaction'
      description 'A server SHALL support the DiagnosticReport read interaction.'

      id :au_core_v030_diagnostic_report_read_test

      def resource_type
        'DiagnosticReport'
      end

      def scratch_resources
        scratch[:diagnostic_report_resources] ||= {}
      end

      run do
        perform_read_test(all_scratch_resources)
      end
    end
  end
end
