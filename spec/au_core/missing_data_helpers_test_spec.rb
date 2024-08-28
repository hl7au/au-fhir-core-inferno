# frozen_string_literal: true

require 'rspec'
require_relative '../../lib/au_core_test_kit/helpers'

RSpec.describe 'Missing data helpers' do
  resource_content = {
    "resourceType": 'Observation',
    "id": 'pathresult-suppressed-valueQuantity',
    "meta": {
      "profile": [
        'http://hl7.org.au/fhir/core/StructureDefinition/au-core-diagnosticresult-path'
      ]
    },
    "code": {
      "coding": [
        {
          "system": 'http://terminology.hl7.org/CodeSystem/data-absent-reason',
          "code": 'unknown',
          "display": 'Unknown'
        }
      ],
      "text": 'Unknown'
    },
    "valueQuantity": {
      "extension": [
        {
          "url": 'http://hl7.org/fhir/StructureDefinition/data-absent-reason',
          "valueCode": 'masked'
        }
      ]
    }
  }

  resource_content_without_dar = resource_content.dup
  resource_content_without_dar.delete(:valueQuantity)
  resource_content_without_dar.delete(:code)

  it 'Should return true when DAR extension is exist in the resource' do
    expect(
      Helpers.check_for_dar_extension(
        FHIR::Observation.new(
          resource_content
        )
      )
    ).to eq(true)
  end

  it 'Should return false when DAR extension is not exist in the resource' do
    expect(
      Helpers.check_for_dar_extension(
        FHIR::Observation.new(
          resource_content_without_dar
        )
      )
    ).to eq(false)
  end

  it 'Should return true when DAR code is exist in the resource' do
    expect(
      Helpers.check_for_dar(
        FHIR::Observation.new(
          resource_content
        )
      )
    ).to eq(true)
  end

  it 'Should return false when DAR code is not exist in the resource' do
    expect(
      Helpers.check_for_dar(
        FHIR::Observation.new(
          resource_content_without_dar
        )
      )
    ).to eq(false)
  end
end
