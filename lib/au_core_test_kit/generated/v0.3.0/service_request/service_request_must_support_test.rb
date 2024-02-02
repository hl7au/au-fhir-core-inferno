require_relative '../../../must_support_test'

module AUCoreTestKit
  module AUCoreV030
    class ServiceRequestMustSupportTest < Inferno::Test
      include AUCoreTestKit::MustSupportTest

      title 'All must support elements are provided in the ServiceRequest resources returned'
      description %(
        AU Core Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the AU Core Server Capability
        Statement. This test will look through the ServiceRequest resources
        found previously for the following must support elements:

        * ServiceRequest.authoredOn
        * ServiceRequest.basedOn
        * ServiceRequest.category
        * ServiceRequest.code
        * ServiceRequest.encounter
        * ServiceRequest.identifier
        * ServiceRequest.intent
        * ServiceRequest.performer
        * ServiceRequest.performerType
        * ServiceRequest.reasonCode
        * ServiceRequest.reasonReference
        * ServiceRequest.requester
        * ServiceRequest.status
        * ServiceRequest.subject
        * ServiceRequest.supportingInfo
      )

      id :au_core_v030_service_request_must_support_test

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
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
