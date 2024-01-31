require_relative '../../../read_test'

module USCoreTestKit
  module USCoreV030
    class AuCoreDiagnosticReportReadTest < Inferno::Test
      include USCoreTestKit::ReadTest

      title 'Server returns correct DiagnosticReport resource from DiagnosticReport read interaction'
      description 'A server SHALL support the DiagnosticReport read interaction.'

      id :us_core_v030_au_core_diagnostic_report_read_test

      def resource_type
        'DiagnosticReport'
      end

      def scratch_resources
        scratch[:au_core_diagnostic_report_resources] ||= {}
      end

      run do
        perform_read_test(all_scratch_resources)
      end
    end
  end
end
