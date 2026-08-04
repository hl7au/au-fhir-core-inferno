# frozen_string_literal: true

require_relative '../../../generators/custom_identifier_search/special_identifier_search_test'

module AUCoreTestKit
  module AUCoreV300_BALLOT1
    class PatientIdentifierMedicareSearchTest < InfernoSuiteGenerator::SpecialIdentifierSearchTest
      title '(SHOULD) Server returns valid results for Patient search by identifier (Medicare)'
      description %(A server SHOULD support searching by
identifier (Medicare) on the Patient resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core/3.0.0-ballot1/CapabilityStatement-au-core-server.html)
)

      id :au_core_v300_ballot1_patient_identifier_medicare_search_test
      optional

      def self.properties
        @properties ||= SearchTestProperties.new(
          resource_type: 'Patient',
          search_param_names: ['identifier'],
          token_search_params: ['identifier'],
          target_identifier: { display: 'Medicare', url: 'http://ns.electronichealth.net.au/id/medicare-number' }
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
