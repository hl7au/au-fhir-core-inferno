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
    "status": 'final',
    "category": [
      {
        "coding": [
          {
            "system": 'http://terminology.hl7.org/CodeSystem/observation-category',
            "code": 'laboratory',
            "display": 'Laboratory'
          }
        ]
      },
      {
        "coding": [
          {
            "system": 'http://terminology.hl7.org/CodeSystem/v2-0074',
            "code": 'CH',
            "display": 'Chemistry'
          }
        ],
        "text": 'Chemistry'
      }
    ],
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
    "subject": {
      "reference": 'Patient/banks-mia-leanne'
    },
    "effectiveDateTime": '2023-01-17',
    "valueQuantity": {
      "extension": [
        {
          "url": 'http://hl7.org/fhir/StructureDefinition/data-absent-reason',
          "valueCode": 'masked'
        }
      ]
    },
    "interpretation": [
      {
        "coding": [
          {
            "system": 'http://terminology.hl7.org/CodeSystem/v3-ObservationInterpretation',
            "code": 'H',
            "display": 'High'
          }
        ]
      }
    ],
    "note": [
      {
        "text": 'This quantity test result is suppressed'
      }
    ],
    "referenceRange": [
      {
        "high": {
          "value": 5.6,
          "unit": 'mmol/L',
          "system": 'http://unitsofmeasure.org',
          "code": 'mmol/L'
        }
      }
    ]
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
