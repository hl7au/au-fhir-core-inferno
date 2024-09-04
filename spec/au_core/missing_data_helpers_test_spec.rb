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

  resource_content_masked = resource_content.dup
  resource_content_masked[:code][:coding][0][:code] = 'masked'
  resource_content_masked[:code][:coding][0][:display] = 'Masked'

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

  it 'Should return true when DAR code (masked) is exist in the resource' do
    expect(
      Helpers.check_for_dar(
        FHIR::Observation.new(
          resource_content_masked
        )
      )
    ).to eq(true)
  end

  it 'Should correct filter resources by id' do
    resources = [
      FHIR::Condition.new({ "id": 'condition-1' }),
      FHIR::Condition.new({ "id": 'condition-1' }),
      FHIR::Condition.new({ "id": 'condition-2' }),
      FHIR::Patient.new({ "id": 'condition-1' })
    ]

    result = Helpers.return_uniq_list_resources(
      resources
    ).sort_by(
      &:resourceType
    ).map(
      &:resourceType
    )

    expect(result.count).to eq(3)
    expect(result).to eq(%w[Condition Condition Patient])
  end
end
