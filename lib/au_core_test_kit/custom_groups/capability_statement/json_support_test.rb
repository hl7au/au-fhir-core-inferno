# frozen_string_literal: true

module AUCoreTestKit
  class JSONSupportTest < Inferno::Test
    id :au_core_json_support
    title 'FHIR server capability states JSON support'
    description %(
      FHIR provides multiple [representation
      formats](https://www.hl7.org/fhir/formats.html) for resources, including
      JSON and XML. AU Core profiles require servers to use the [JSON
      representation](https://www.hl7.org/fhir/json.html):

      [```The AU Core Server **SHALL** Support json source formats for all AU Core Responder interactions```](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html#title)

      The FHIR conformance interaction require servers to describe which
      formats are available for clients to use. The server must explicitly
      state that JSON is supported. This is located in the format element
      of the CapabilityStatement Resource.

      This test checks that one of the following values are located in the
      format field.

      * json
      * application/json
      * application/fhir+json
    )
    uses_request :capability_statement

    run do
      assert_resource_type(:capability_statement)

      json_formats = ['json', 'application/json', 'application/fhir+json']
      server_formats = resource.format

      assert server_formats.any? { |format| json_formats.include? format },
             'CapabilityStatement does not state support for JSON'
    end
  end
end
