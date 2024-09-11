# frozen_string_literal: true

require_relative '../../../search_test'
require_relative '../../../generator/group_metadata'
require_relative '../../../helpers'

module AUCoreTestKit
  module AUCoreV100_BALLOT
    class PatientIdentifierSearchTest < Inferno::Test
      include AUCoreTestKit::SearchTest

      title '(SHALL) Server returns valid results for Patient search by identifier'
      description %(
A server SHALL support searching by
identifier on the Patient resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html)

      )

      id :au_core_v100_ballot_patient_identifier_search_test
      def self.properties
        @properties ||= SearchTestProperties.new(
          resource_type: 'Patient',
          search_param_names: ['identifier'],
          token_search_params: ['identifier']
        )
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:patient_resources] ||= {}
      end

      run do
        run_search_test_with_system
      end
    end
  end
end
