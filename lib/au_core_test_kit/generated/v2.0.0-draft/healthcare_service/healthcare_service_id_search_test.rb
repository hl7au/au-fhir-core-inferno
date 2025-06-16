# frozen_string_literal: true

require_relative '../../../search_test'
require_relative '../../../generator/group_metadata'
require_relative '../../../helpers'

module AUCoreTestKit
  module AUCoreV200_DRAFT
    class HealthcareServiceIdSearchTest < Inferno::Test
      include AUCoreTestKit::SearchTest

      title '(SHOULD) Server returns valid results for HealthcareService search by _id'
      description %(
A server SHOULD support searching by
_id on the HealthcareService resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html)

      )

      id :au_core_v200_draft_healthcare_service__id_search_test
      optional

      def self.properties
        @properties ||= SearchTestProperties.new(
          resource_type: 'HealthcareService',
          search_param_names: ['_id']
        )
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:healthcare_service_resources] ||= {}
      end

      run do
        run_search_test
      end
    end
  end
end
