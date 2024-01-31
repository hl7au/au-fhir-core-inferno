module USCoreTestKit
  class ProvenanceValidator
    include FHIRResourceNavigation

    def self.validate(...)
      new(...).validate
    end

    attr_reader :resource, :validation_messages

    def initialize(resource)
      @resource = resource
      @validation_messages = []
    end

    def validate
      # Invariant provenance-1 in US Core 5 causes validation error. See FHIR-39518
      return validation_messages unless resource.instance_of?(FHIR::Provenance)

      failed_provenance =
        find_a_value_at(resource, 'agent') do |agent|
          ['Practitioner', 'Device'].any? { |resource_type| agent.who.reference&.include?(resource_type) } &&
          agent.onBehalfOf.nil?
        end


      if failed_provenance.present?
        validation_messages << {
          type: 'error',
          message: "#{resource.resourceType}/#{resource.id}: Rule provenance-1: 'onBehalfOf SHALL be present when Provenance.agent.who is a Practitioner or Device' Failed"
        }
      end

      validation_messages
    end
  end
end