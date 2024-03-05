module AUCoreTestKit
  class ConformanceSupportTest < Inferno::Test
    id :au_core_conformance_support
    title 'FHIR Server supports the conformance interaction'
    description %(
      The conformance 'whole system' interaction provides a method to get the
      CapabilityStatement for the FHIR server. This test checks that the
      server responds to a `GET` request at the following endpoint:

      ```
      GET [base]/metadata
      ```

      This test checks the following SHALL requirement:

      > Applications SHALL return a resource that describes the functionality
        of the server end-point.

      [http://hl7.org/fhir/R4/http.html#capabilities](http://hl7.org/fhir/R4/http.html#capabilities)

      It does this by checking that the server responds with an HTTP OK 200
      status code and that the body of the response contains a valid
      [CapabilityStatement
      resource](http://hl7.org/fhir/R4/capabilitystatement.html). This test
      does not inspect the content of the CapabilityStatement to see if it
      contains the required information. It only checks to see if the RESTful
      interaction is supported and returns a valid CapabilityStatement
      resource.
    )
    makes_request :capability_statement

    run do
      fhir_client.set_no_auth
      fhir_get_capability_statement(name: :capability_statement)

      assert_response_status(200)
      assert_resource_type(:capability_statement)
      assert_valid_resource
    end
  end
end
