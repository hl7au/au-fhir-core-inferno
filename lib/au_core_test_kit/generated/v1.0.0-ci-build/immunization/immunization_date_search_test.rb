# frozen_string_literal: true

require_relative '../../../search_test'
require_relative '../../../generator/group_metadata'
require_relative '../../../helpers'

module AUCoreTestKit
  module AUCoreV100_CI_BUILD
    class ImmunizationDateSearchTest < Inferno::Test
      include AUCoreTestKit::SearchTest

      title '(MAY) Server returns valid results for Immunization search by date'
      description %(
A server MAY support searching by
date on the Immunization resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html)

      )

      id :au_core_v100_ci_build_immunization_date_search_test
      optional

      def self.properties
        @properties ||= SearchTestProperties.new(
          resource_type: 'Immunization',
          search_param_names: ['date'],
          possible_status_search: true,
          params_with_comparators: ['date']
        )
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:immunization_resources] ||= {}
      end

      run do
        run_search_test
      end
    end
  end
end
