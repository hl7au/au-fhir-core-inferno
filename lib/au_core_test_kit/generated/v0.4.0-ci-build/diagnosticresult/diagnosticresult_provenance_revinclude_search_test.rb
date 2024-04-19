# frozen_string_literal: true

require_relative '../../../search_test'
require_relative '../../../generator/group_metadata'

module AUCoreTestKit
  module AUCoreV040_CI_BUILD
    class DiagnosticresultProvenanceRevincludeSearchTest < Inferno::Test
      include AUCoreTestKit::SearchTest

      title 'Server returns Provenance resources from Observation search by patient + revInclude:Provenance:target'
      description %(
        A server SHALL be capable of supporting _revIncludes:Provenance:target.

        This test will perform a search by patient + revInclude:Provenance:target and
        will pass if a Provenance resource is found in the response.
      %)

      id :au_core_v040_ci_build_diagnosticresult_provenance_revinclude_search_test

      input :patient_ids,
            title: 'Patient IDs',
            description: 'Comma separated list of patient IDs that in sum contain all MUST SUPPORT elements',
            default: 'bennelong-anne, smith-emma, baby-smith-john, dan-harry, italia-sofia, wang-li'

      def properties
        @properties ||= SearchTestProperties.new(
          resource_type: 'Observation',
          search_param_names: ['patient'],
          possible_status_search: true
        )
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml')))
      end

      def self.provenance_metadata
        @provenance_metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, '..', 'provenance', 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:diagnosticresult_resources] ||= {}
      end

      def scratch_provenance_resources
        scratch[:provenance_resources] ||= {}
      end

      run do
        run_provenance_revinclude_search_test
      end
    end
  end
end
