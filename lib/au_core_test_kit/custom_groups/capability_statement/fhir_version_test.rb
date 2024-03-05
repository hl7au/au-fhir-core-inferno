module AUCoreTestKit
  class FHIRVersionTest < Inferno::Test
    id :au_core_fhir_version
    title 'Server is using FHIR R4'
    description %(
        This test inspects the CapabilityStatement returned by the server to
        verify that the server is using FHIR R4.
      )

    run do
      server_version = fhir_client.detect_version.to_s.upcase
      assert server_version == 'R4', "Server is using FHIR version #{server_version} rather than R4"
    end
  end
end
