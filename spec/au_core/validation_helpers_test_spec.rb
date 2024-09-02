# frozen_string_literal: true

require 'rspec'
require_relative '../../lib/au_core_test_kit/helpers'

RSpec.describe 'Validator helpers' do
  message_list = [
    "The value provided ('xml') was not found in the value set 'MimeType'"
  ]
  message_xml = "CapabilityStatement/61a65c7c-4f56-4f45-9342-38699af77e51: CapabilityStatement.format[1]: The value provided ('xml') was not found in the value set 'MimeType' (http://hl7.org/fhir/ValueSet/mimetypes|4.0.1), and a code is required from this value set  (error message = The System URI could not be determined for the code 'xml' in the ValueSet 'http://hl7.org/fhir/ValueSet/mimetypes|4.0.1'; None of the provided codes ['#xml'] are in the value set 'http://hl7.org/fhir/ValueSet/mimetypes|4.0.1')"
  message_json = "CapabilityStatement/61a65c7c-4f56-4f45-9342-38699af77e51: CapabilityStatement.format[3]: The value provided ('json') was not found in the value set 'MimeType' (http://hl7.org/fhir/ValueSet/mimetypes|4.0.1), and a code is required from this value set  (error message = The System URI could not be determined for the code 'json' in the ValueSet 'http://hl7.org/fhir/ValueSet/mimetypes|4.0.1'; None of the provided codes ['#json'] are in the value set 'http://hl7.org/fhir/ValueSet/mimetypes|4.0.1')"

  it 'It should return true if string exist in target message' do
    expect(
      Helpers.is_message_exist_in_list(
        message_list,
        message_xml
      )
    ).to eq(true)
  end

  it 'It should return false if string not exist in target message' do
    expect(
      Helpers.is_message_exist_in_list(
        message_list,
        message_json
      )
    ).to eq(false)
  end
end
