module AUCoreTestKit
  class InstantiateTest < Inferno::Test
    id :au_core_instantiate
    title 'Server instantiates AU Core Server'
    description %(
        This test inspects the CapabilityStatement returned by the server to
        verify that the server instantiates http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html
      )
    uses_request :capability_statement

    run do
      assert_resource_type(:capability_statement)
      capability_statement = resource

      assert capability_statement.instantiates.include?('http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html'),
        "Server CapabilityStatement.instantiates does not include 'http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html'"
    end
  end
end
