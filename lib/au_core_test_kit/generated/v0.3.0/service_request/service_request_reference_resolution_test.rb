require_relative '../../../reference_resolution_test'

module AUCoreTestKit
  module AUCoreV030
    class ServiceRequestReferenceResolutionTest < Inferno::Test
      include AUCoreTestKit::ReferenceResolutionTest

      title 'MustSupport references within ServiceRequest resources are valid'
      description %(
        This test will attempt to read external references provided within elements
        marked as 'MustSupport', if any are available.

        It verifies that at least one external reference for each MustSupport Reference element
        can be accessed by the test client, and conforms to corresponding AU Core profile.

        Elements which may provide external references include:

        * ServiceRequest.basedOn
        * ServiceRequest.encounter
        * ServiceRequest.performer
        * ServiceRequest.reasonReference
        * ServiceRequest.requester
        * ServiceRequest.subject
        * ServiceRequest.supportingInfo
      )

      id :au_core_v030_service_request_reference_resolution_test

      def resource_type
        'ServiceRequest'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:service_request_resources] ||= {}
      end

      run do
        perform_reference_resolution_test(scratch_resources[:all])
      end
    end
  end
end
