# frozen_string_literal: true

require_relative '../../../generators/custom_identifier_search/special_identifier_search_test'

module AUCoreTestKit
  module AUCoreV200
    class PatientIdentifierIHISearchTest < InfernoSuiteGenerator::SpecialIdentifierSearchTest
      title '(SHOULD) Server returns valid results for Patient search by identifier (IHI)'
      description %(A server SHOULD support searching by
identifier (IHI) on the Patient resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/2.0.0/CapabilityStatement-au-core-server.html)
)

      id :au_core_v200_patient_identifier_ihi_search_test
      optional

      def self.properties
        @properties ||= SearchTestProperties.new(
          resource_type: 'Patient',
          search_param_names: ['identifier'],
          token_search_params: ['identifier'],
          target_identifier: { display: 'IHI', url: 'http://ns.electronichealth.net.au/id/hi/ihi/1.0' }
        )
      end

      def self.metadata
        @metadata ||= InfernoSuiteGenerator::Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
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
