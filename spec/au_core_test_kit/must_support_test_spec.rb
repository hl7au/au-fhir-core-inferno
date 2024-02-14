# frozen_string_literal: true

require 'rspec'
require_relative '../../lib/au_core_test_kit/helpers'

RSpec.describe 'AUCoreTestKit::MustSupportTest' do
  it 'Should return all extensions' do
    test_resource = FHIR::Patient.new(
      {
        address: [
          {
            use: "home",
            city: "Blacktown",
            line: ["29 Gadsby Street"],
            state: "NSW",
            country: "AU",
            postalCode: "2148"
          }
        ],
        meta: {
          profile: ["http://hl7.org.au/fhir/core/StructureDefinition/au-core-patient"],
          lastUpdated: "2023-11-17T16:09:49.949207Z",
          versionId: "2",
          extension: [
            {
              url: "ex:createdAt",
              valueInstant: "2023-11-17T16:09:49.949207Z"
            }
          ]
        },
        name: [
          {
            given: ["Li"],
            family: "Wang",
            prefix: ["Mr"]
          }
        ],
        birthDate: "1975-05-03",
        _birthDate: {
          extension: [
            {
              url: "http://hl7.org.au/fhir/StructureDefinition/date-accuracy-indicator",
              valueCoding: {
                code: "AAA",
                system: "https://healthterminologies.gov.au/fhir/CodeSystem/date-accuracy-indicator-1",
                display: "Day, month and year are accurate"
              }
            }
          ]
        },
        resourceType: "Patient",
        extension: [
          {
            url: "http://hl7.org.au/fhir/StructureDefinition/date-of-arrival",
            valueDate: "2015"
          },
          {
            url: "http://hl7.org/fhir/StructureDefinition/patient-interpreterRequired",
            valueBoolean: true
          },
          {
            url: "http://hl7.org.au/fhir/StructureDefinition/indigenous-status",
            valueCoding: {
              code: "4",
              system: "https://healthterminologies.gov.au/fhir/CodeSystem/australian-indigenous-status-1",
              display: "Neither Aboriginal nor Torres Strait Islander origin"
            }
          },
          {
            url: "http://hl7.org/fhir/StructureDefinition/patient-birthPlace",
            valueAddress: {
              text: "China",
              country: "CHN"
            }
          }
        ],
        communication: [
          {
            language: {
              text: "Cantonese",
              coding: [
                {
                  code: "yue",
                  system: "urn:ietf:bcp:47"
                }
              ]
            },
            preferred: true
          }
        ],
        id: "wang-li",
        identifier: [
          {
            type: {
              text: "IHI",
              coding: [
                {
                  code: "NI",
                  system: "http://terminology.hl7.org/CodeSystem/v2-0203"
                }
              ]
            },
            value: "8003608833357361",
            system: "http://ns.electronichealth.net.au/id/hi/ihi/1.0",
            extension: [
              {
                url: "http://hl7.org.au/fhir/StructureDefinition/ihi-status",
                valueCoding: {
                  code: "active",
                  system: "https://healthterminologies.gov.au/fhir/CodeSystem/ihi-status-1"
                }
              },
              {
                url: "http://hl7.org.au/fhir/StructureDefinition/ihi-record-status",
                valueCoding: {
                  code: "verified",
                  system: "https://healthterminologies.gov.au/fhir/CodeSystem/ihi-record-status-1",
                  display: "verified"
                }
              }
            ]
          },
          {
            type: {
              text: "Medicare Number",
              coding: [
                {
                  code: "MC",
                  system: "http://terminology.hl7.org/CodeSystem/v2-0203"
                }
              ]
            },
            value: "29533070322",
            system: "http://ns.electronichealth.net.au/id/medicare-number"
          },
          {
            type: {
              text: "Medical Record Number",
              coding: [
                {
                  code: "MR",
                  system: "http://terminology.hl7.org/CodeSystem/v2-0203",
                  display: "Medical record number"
                }
              ]
            },
            value: "2338189",
            system: "http://ns.electronichealth.net.au/id/hpio-scoped/medicalrecord/1.0/8003626566699734",
            assigner: {
              display: "Large Metropolitan Hospital"
            }
          }
        ],
        gender: "male",
      }
    )
    result = Helpers.extract_extensions_from_resource(test_resource)
    expected_result = [
      {"url"=>"http://hl7.org.au/fhir/StructureDefinition/date-accuracy-indicator", "valueCoding"=>{"code"=>"AAA", "system"=>"https://healthterminologies.gov.au/fhir/CodeSystem/date-accuracy-indicator-1", "display"=>"Day, month and year are accurate"}},
      {"url"=>"ex:createdAt", "valueInstant"=>"2023-11-17T16:09:49.949207Z"},
      {"url"=>"http://hl7.org.au/fhir/StructureDefinition/date-of-arrival", "valueDate"=>"2015"},
      {"url"=>"http://hl7.org/fhir/StructureDefinition/patient-interpreterRequired", "valueBoolean"=>true},
      {"url"=>"http://hl7.org.au/fhir/StructureDefinition/indigenous-status", "valueCoding"=>{"system"=>"https://healthterminologies.gov.au/fhir/CodeSystem/australian-indigenous-status-1", "code"=>"4", "display"=>"Neither Aboriginal nor Torres Strait Islander origin"}},
      {"url"=>"http://hl7.org/fhir/StructureDefinition/patient-birthPlace", "valueAddress"=>{"text"=>"China", "country"=>"CHN"}},
      {"url"=>"http://hl7.org.au/fhir/StructureDefinition/ihi-status", "valueCoding"=>{"system"=>"https://healthterminologies.gov.au/fhir/CodeSystem/ihi-status-1", "code"=>"active"}},
      {"url"=>"http://hl7.org.au/fhir/StructureDefinition/ihi-record-status", "valueCoding"=>{"system"=>"https://healthterminologies.gov.au/fhir/CodeSystem/ihi-record-status-1", "code"=>"verified", "display"=>"verified"}},
    ]
    expect(result.length).to eq(expected_result.length)
  end
end
