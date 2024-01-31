require_relative '../../../search_test'
require_relative '../../../generator/group_metadata'

module USCoreTestKit
  module USCoreV030
    class AuCoreDiagnosticReportPatientCodeSearchTest < Inferno::Test
      include USCoreTestKit::SearchTest

      title 'Server returns valid results for DiagnosticReport search by patient + code'
      description %(
A server SHOULD support searching by
patient + code on the DiagnosticReport resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[US Core Server CapabilityStatement](http://hl7.org/fhir/us/core//CapabilityStatement-us-core-server.html)

      )

      id :us_core_v030_au_core_diagnostic_report_patient_code_search_test
      optional
  
      input :patient_ids,
        title: 'Patient IDs',
        description: 'Comma separated list of patient IDs that in sum contain all MUST SUPPORT elements'
  
      def self.properties
        @properties ||= SearchTestProperties.new(
          resource_type: 'DiagnosticReport',
        search_param_names: ['patient', 'code'],
        possible_status_search: true
        )
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:au_core_diagnostic_report_resources] ||= {}
      end

      run do
        run_search_test
      end
    end
  end
end
