require_relative '../../../search_test'
require_relative '../../../generator/group_metadata'

module AUCoreTestKit
  module AUCoreV030_BALLOT
    class EncounterDischargeDispositionSearchTest < Inferno::Test
      include AUCoreTestKit::SearchTest

      title 'Server returns valid results for Encounter search by discharge-disposition'
      description %(
A server MAY support searching by
discharge-disposition on the Encounter resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)

      )

      id :au_core_v030_ballot_encounter_discharge_disposition_search_test
      optional

      def self.properties
        @properties ||= SearchTestProperties.new(
          resource_type: 'Encounter',
          search_param_names: ['discharge-disposition'],
          possible_status_search: true,
          token_search_params: ['discharge-disposition']
        )
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:encounter_resources] ||= {}
      end

      run do
        run_search_test
      end
    end
  end
end
