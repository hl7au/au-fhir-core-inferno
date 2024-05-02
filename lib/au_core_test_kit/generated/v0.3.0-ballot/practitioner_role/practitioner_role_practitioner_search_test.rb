# frozen_string_literal: true

require_relative '../../../search_test'
require_relative '../../../generator/group_metadata'

module AUCoreTestKit
  module AUCoreV030_BALLOT
    class PractitionerRolePractitionerSearchTest < Inferno::Test
      include AUCoreTestKit::SearchTest

      title 'Server returns valid results for PractitionerRole search by practitioner'
      description %(
A server SHALL support searching by
practitioner on the PractitionerRole resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)

      )

      id :au_core_v030_ballot_practitioner_role_practitioner_search_test
      def self.properties
        @properties ||= SearchTestProperties.new(
          resource_type: 'PractitionerRole',
          search_param_names: ['practitioner']
        )
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:practitioner_role_resources] ||= {}
      end

      run do
        run_search_test
      end
    end
  end
end