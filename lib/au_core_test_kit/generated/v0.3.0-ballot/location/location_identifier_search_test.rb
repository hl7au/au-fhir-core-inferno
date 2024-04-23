# frozen_string_literal: true

require_relative '../../../search_test'
require_relative '../../../generator/group_metadata'

module AUCoreTestKit
  module AUCoreV030_BALLOT
    class LocationIdentifierSearchTest < Inferno::Test
      include AUCoreTestKit::SearchTest

      title 'Server returns valid results for Location search by identifier'
      description %(
A server MAY support searching by
identifier on the Location resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)

      )

      id :au_core_v030_ballot_location_identifier_search_test
      optional

      def self.properties
        @properties ||= SearchTestProperties.new(
          resource_type: 'Location',
          search_param_names: ['identifier'],
          token_search_params: ['identifier']
        )
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:location_resources] ||= {}
      end

      run do
        run_search_test
      end
    end
  end
end
