# frozen_string_literal: true

require_relative '../../../search_test'
require_relative '../../../generator/group_metadata'

module AUCoreTestKit
  module AUCoreV050_CI_BUILD
    class DiagnosticresultPathStatusMultipleOrSearchTest < Inferno::Test
      include AUCoreTestKit::SearchTest

      title '(SHOULD) Server returns valid results for Observation multipleOr search by status'
      description %(A server SHOULD support searching by multipleOr
status on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html)
)

      id :au_core_v050_ci_build_diagnosticresult_path_status_multiple_or_search_test

      optional

      input :patient_ids,
            title: 'Patient IDs',
            description: 'Comma separated list of patient IDs that in sum contain all MUST SUPPORT elements',
            default: 'bennelong-anne, smith-emma, baby-smith-john, dan-harry, italia-sofia, wang-li, hayes-maria'

      def self.properties
        @properties ||= SearchTestProperties.new(resource_type: 'Observation',
                                                 search_param_names: ['status'],
                                                 multiple_or_search_params: true)
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:diagnosticresult_path_resources] ||= {}
      end

      run do
        perform_multiple_or_search_test
      end
    end
  end
end
