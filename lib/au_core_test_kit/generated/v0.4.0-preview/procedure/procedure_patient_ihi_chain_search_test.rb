# frozen_string_literal: true

require_relative '../../../chained_search_test'
require_relative '../../../generator/group_metadata'

module AUCoreTestKit
  module AUCoreV040_PREVIEW
    class ProcedurePatient_IHI_ChainSearchTest < Inferno::Test
      include AUCoreTestKit::ChainedSearchTest

      title '(SHOULD) Server returns valid results for Procedure search by patient (IHI) (chained parameters)'
      description %(A server SHOULD support searching by
patient:Patient.identifier (IHI) on the Procedure resource. This test
will pass if the server returns a success response to the request.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html)
)

      id :au_core_v040_preview_procedure_patient_ihi_chain_search_test

      optional

      input :patient_ids,
            title: 'Patient IDs',
            description: 'Comma separated list of patient IDs that in sum contain all MUST SUPPORT elements',
            default: 'bennelong-anne, smith-emma, baby-smith-john, dan-harry, italia-sofia, wang-li'

      def self.properties
        @properties ||= SearchTestProperties.new(
          resource_type: 'Procedure',
          search_param_names: ['patient:Patient.identifier'],
          attr_paths: ['subject'],
          target_identifier: { display: 'IHI', url: 'http://ns.electronichealth.net.au/id/hi/ihi/1.0' }
        )
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:procedure_resources] ||= {}
      end

      run do
        run_chain_search_test
      end
    end
  end
end
