# frozen_string_literal: true

module AUCoreTestKit
  class XMLSupportTest < Inferno::Test
    id :au_core_xml_support
    title 'FHIR server capability states XML support'
    description %(
      FHIR provides multiple [representation
      formats](https://www.hl7.org/fhir/formats.html) for resources, including
      JSON and XML. AU Core profiles require servers to use the [XML
      representation](https://www.hl7.org/fhir/xml.html):

      [```The AU Core Server **SHOULD** Support json source formats for all AU Core Responder interactions```](http://hl7.org.au/fhir/core/0.3.0-ballot/CapabilityStatement-au-core-server.html#title)

      The FHIR conformance interaction require servers to describe which
      formats are available for clients to use. The server must explicitly
      state that XML is supported. This is located in the format element
      of the CapabilityStatement Resource.

      This test checks that one of the following values are located in the
      format field.

      * xml
      * application/xml
      * application/fhir+xml
    )
    optional true
    uses_request :capability_statement

    run do
      assert_resource_type(:capability_statement)

      xml_formats = ['xml', 'application/xml', 'application/fhir+xml']
      server_formats = resource.format

      assert server_formats.any? { |format| xml_formats.include? format },
             'CapabilityStatement does not state support for XML'
    end
  end
end
