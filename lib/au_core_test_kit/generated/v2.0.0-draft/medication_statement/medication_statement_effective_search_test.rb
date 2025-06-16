# frozen_string_literal: true

require_relative '../../../search_test'
require_relative '../../../generator/group_metadata'
require_relative '../../../helpers'

module AUCoreTestKit
  module AUCoreV200_DRAFT
    class MedicationStatementEffectiveSearchTest < Inferno::Test
      include AUCoreTestKit::SearchTest

      title '(MAY) Server returns valid results for MedicationStatement search by effective'
      description %(
A server MAY support searching by
effective on the MedicationStatement resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html)

      )

      id :au_core_v200_draft_medication_statement_effective_search_test
      optional

      def self.properties
        @properties ||= SearchTestProperties.new(
          resource_type: 'MedicationStatement',
          search_param_names: ['effective'],
          possible_status_search: true,
          includes: [{ 'parameter' => 'MedicationStatement:medication', 'target_resource' => 'Medication', 'paths' => ['medicationReference'] }]
        )
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:medication_statement_resources] ||= {}
      end

      run do
        run_search_test
      end
    end
  end
end
