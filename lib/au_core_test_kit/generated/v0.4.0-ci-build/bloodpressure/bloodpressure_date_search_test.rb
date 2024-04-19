# frozen_string_literal: true

require_relative '../../../search_test'
require_relative '../../../generator/group_metadata'

module AUCoreTestKit
  module AUCoreV040_CI_BUILD
    class BloodpressureDateSearchTest < Inferno::Test
      include AUCoreTestKit::SearchTest

      title 'Server returns valid results for Observation search by date'
      description %(
A server MAY support searching by
date on the Observation resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html)

      )

      id :au_core_v040_ci_build_bloodpressure_date_search_test
      optional

      def self.properties
        @properties ||= SearchTestProperties.new(
          resource_type: 'Observation',
          search_param_names: ['date'],
          possible_status_search: true
        )
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:bloodpressure_resources] ||= {}
      end

      run do
        run_search_test
      end
    end
  end
end
