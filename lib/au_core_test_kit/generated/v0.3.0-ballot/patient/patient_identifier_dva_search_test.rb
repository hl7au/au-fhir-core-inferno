# frozen_string_literal: true

require_relative '../../../special_identifier_search_test'
require_relative '../../../generator/group_metadata'

module AUCoreTestKit
  module AUCoreV030_BALLOT
    class PatientIdentifier_DVASearchTest < Inferno::Test
      include AUCoreTestKit::SpecialIdentifierSearchTest

      title %(Server returns valid results for Patient search by identifier (DVA))
      description %(A server SHOULD support searching by
identifier (DVA) on the Patient resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html)
)

      id :au_core_v030_ballot_patient_identifier_dva_search_test
      optional

      def self.properties
        @properties ||= SearchTestProperties.new(
          resource_type: 'Patient',
          search_param_names: ['identifier'],
          token_search_params: ['identifier'],
          target_identifier: { display: 'DVA', url: 'http://ns.electronichealth.net.au/id/dva' }
        )
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:patient_resources] ||= {}
      end

      run do
        run_special_identifier_search_test
      end
    end
  end
end
