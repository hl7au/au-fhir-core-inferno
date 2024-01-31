RSpec.describe USCoreTestKit::MustSupportTest do
  let(:suite) { Inferno::Repositories::TestSuites.new.find('us_core_v400') }
  let(:session_data_repo) { Inferno::Repositories::SessionData.new }
  let(:test_session) { repo_create(:test_session, test_suite_id: suite.id) }
  let(:patient_ref) { 'Patient/85' }

  def run(runnable, inputs = {})
    test_run_params = { test_session_id: test_session.id }.merge(runnable.reference_hash)
    test_run = Inferno::Repositories::TestRuns.new.create(test_run_params)
    inputs.each do |name, value|
      session_data_repo.save(
        test_session_id: test_session.id,
        name: name,
        value: value,
        type: runnable.config.input_type(name)
      )
    end
    Inferno::TestRunner.new(test_session: test_session, test_run: test_run).run(runnable)
  end

  describe 'must support test for choice elements and regular elements' do
    let(:device_must_support_test) { Inferno::Repositories::Tests.new.find('us_core_v311_device_must_support_test')}
    let(:device) do
      FHIR::Device.new(
        udiCarrier: [{ deviceIdentifier: '43069338026389', carrierHRF: 'carrierHRF' }],
        distinctIdentifier: '43069338026389',
        manufactureDate: '2000-03-02T18:33:18-05:00',
        expirationDate: '2025-03-17T19:33:18-04:00',
        lotNumber: '1134',
        serialNumber: '842026117977',
        type: {
          text: 'Implantable defibrillator, device (physical object)'
        },
        patient: {
          reference: patient_ref
        }
      )
    end

    it 'fails if server supports none of the choice' do
      device.udiCarrier.first.carrierHRF = nil
      allow_any_instance_of(device_must_support_test)
        .to receive(:scratch_resources).and_return(
          {
            all: [device]
          }
        )

      result = run(device_must_support_test)
      expect(result.result).to eq('skip')
      expect(result.result_message).to include('udiCarrier.carrierAIDC, udiCarrier.carrierHRF')
    end

    it 'passes if server supports at least one of the choice' do
      allow_any_instance_of(device_must_support_test)
        .to receive(:scratch_resources).and_return(
          {
            all: [device]
          }
        )

      result = run(device_must_support_test)
      expect(result.result).to eq('pass')
    end

    it 'fails if server does not support one MS element' do
      device.distinctIdentifier = nil
      allow_any_instance_of(device_must_support_test)
        .to receive(:scratch_resources).and_return(
          {
            all: [device]
          }
        )

      result = run(device_must_support_test)
      expect(result.result).to eq('skip')
      expect(result.result_message).to include('distinctIdentifier')
    end
  end

  describe 'must support test for extensions' do
    let(:patient_must_support_test) { Inferno::Repositories::Tests.new.find('us_core_v311_patient_must_support_test')}
    let(:patient) do
      FHIR::Patient.new(
        identifier: [{system: 'system', value: 'value'}],
        name: [{family: 'family', given: 'given'}],
        telecom: [{system: 'phone', value: 'value', use: 'home'}],
        gender: 'male',
        birthDate: '2020-01-01',
        address: [{line: 'line', city: 'city', state: 'state', postalCode: 'postalCode', period: {start: '2020-01-01'}}],
        communication: [{language: {text: 'text'}}],
        extension: [
          {
            url: 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-race',
            extension: [
              {url: 'ombCategory', valueCoding: {display: 'display'}},
              {url: 'text', valueString: 'valueString'}
            ]
          },
          {
            url: 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-ethnicity',
            extension: [
              {url: 'ombCategory', valueCoding: {display: 'display'}},
              {url: 'text', valueString: 'valueString'}
            ]
          },
          {
            url: 'http://hl7.org/fhir/us/core/StructureDefinition/us-core-birthsex',
            valueCode: 'M'
          }
        ]
      )
    end

    it 'passes if server suports all MS extensions' do
      allow_any_instance_of(patient_must_support_test)
        .to receive(:scratch_resources).and_return(
          {
            all: [patient]
          }
        )

      result = run(patient_must_support_test)

      expect(result.result).to eq('pass')
    end

    it 'fails if server does not suport one MS extensions' do
      patient.extension.delete_at(0)

      allow_any_instance_of(patient_must_support_test)
        .to receive(:scratch_resources).and_return(
          {
            all: [patient]
          }
        )

      result = run(patient_must_support_test)

      expect(result.result).to eq('skip')
      expect(result.result_message).to include('Patient.extension:race')
    end
  end

  describe 'must support test for slices' do
    context 'slicing with pattern' do
      let(:care_plan_must_support_test) { Inferno::Repositories::Tests.new.find('us_core_v311_care_plan_must_support_test')}
      let(:careplan) do
        FHIR::CarePlan.new(
          text: { status: 'status' },
          status: 'status',
          intent: 'intent',
          category: [
            {
              coding: [
                {
                  system: 'http://hl7.org/fhir/us/core/CodeSystem/careplan-category',
                  code: 'assess-plan'
                }
              ]
            }
          ],
          subject: {
            reference: patient_ref
          }
        )
      end

      it 'passes if server suports all MS slices' do
        allow_any_instance_of(care_plan_must_support_test)
          .to receive(:scratch_resources).and_return(
            {
              all: [careplan]
            }
          )


        result = run(care_plan_must_support_test)

        expect(result.result).to eq('pass')
      end

      it 'fails if server does not suport one MS extensions' do
        careplan.category.first.coding.first.code = 'something else'
        allow_any_instance_of(care_plan_must_support_test)
          .to receive(:scratch_resources).and_return(
            {
              all: [careplan]
            }
          )

        result = run(care_plan_must_support_test)

        expect(result.result).to eq('skip')
        expect(result.result_message).to include('CarePlan.category:AssessPlan')
      end
    end

    context 'slicing with type' do
      let(:test_class) { USCoreTestKit::USCoreV400::SmokingstatusMustSupportTest }
      let(:observation) {
        FHIR::Observation.new(
          status: 'final',
          category: [
            {
              coding: [
                {
                  system: 'http://terminology.hl7.org/CodeSystem/observation-category',
                  code: 'social-history'
                }
              ]
            }
          ],
          code: {
            coding: [
              {
                system: 'http://loinc.org',
                code: '72166-2'
              }
            ],
            text: 'Tobacco smoking status'
          },
          subject: {
            reference: 'Patient/902'
          },
          effectiveDateTime: '2013-04-23T21:07:05Z',
          valueCodeableConcept: {
            coding: [
              {
                system: 'http://snomed.info/sct',
                code: '449868002'
              }
            ]
          }
        )
      }

      it 'passes if server suports all MS slices' do
        allow_any_instance_of(test_class)
        .to receive(:scratch_resources).and_return(
          {
            all: [observation]
          }
        )


        result = run(test_class)

        expect(result.result).to eq('pass')
      end

      it 'skips if datetime format is not correct' do
        observation.effectiveDateTime = "not a date time"
        allow_any_instance_of(test_class)
        .to receive(:scratch_resources).and_return(
          {
            all: [observation]
          }
        )


        result = run(test_class)

        expect(result.result).to eq('skip')
        expect(result.result_message).to include('Observation.effective[x]:effectiveDateTime')
      end
    end

    context 'slicing with requiredBinding' do
      context 'Condition ProblemsHealthConcerns' do
        let(:test_class) { USCoreTestKit::USCoreV501::ConditionProblemsHealthConcernsMustSupportTest }
        let(:condition) {
          FHIR::Condition.new(
            extension: [
              {
                url: 'http://hl7.org/fhir/StructureDefinition/condition-assertedDate',
                valueDateTime: '2016-08-10'
              }
            ],
            clinicalStatus: {
              coding: [
                {
                  system: 'http://terminology.hl7.org/CodeSystem/condition-clinical',
                  code: 'active'
                }
              ]
            },
            verificationStatus: {
              coding: [
                {
                  system: 'http://terminology.hl7.org/CodeSystem/condition-ver-status',
                  code: 'confirmed'
                }
              ]
            },
            category: [
              {
                coding: [
                  {
                    system: 'http://terminology.hl7.org/CodeSystem/condition-category',
                    code: 'problem-list-item'
                  }
                ]
              },
              {
                coding: [
                  {
                    system: 'http://hl7.org/fhir/us/core/CodeSystem/us-core-tags',
                    code: 'sdoh'
                  }
                ]
              }
            ],
            code: {
              coding: [
                {
                  system: 'http://snomed.info/sct',
                  code: '445281000124101'
                }
              ]
            },
            subject: {
              reference: 'Patient/123',
            },
            recordedDate: '2016-08-10T07:15:07-08:00',
            onsetDateTime: '2016-08-10T07:15:07-08:00',
            abatementDateTime: '2016-08-10T07:15:07-08:00'
          )
        }

        it 'passes if server suports all MS slices' do
          allow_any_instance_of(test_class)
            .to receive(:scratch_resources).and_return(
              {
                all: [condition]
              }
            )


          result = run(test_class)
          expect(result.result).to eq('pass')
        end

        it 'skips if server does not support category:us-core slice' do
          condition.category.delete_if { |category| category.coding.first.code == 'problem-list-item' }
          allow_any_instance_of(test_class)
          .to receive(:scratch_resources).and_return(
            {
              all: [condition]
            }
          )

          result = run(test_class)
          expect(result.result).to eq('skip')
          expect(result.result_message).to include('Condition.category:us-core')
        end
      end

      context 'MedicationRequest' do
        let(:test_class) { USCoreTestKit::USCoreV501::MedicationRequestMustSupportTest }
        let(:medication_request_1) {
          FHIR::MedicationRequest.new(
            status: 'active',
            intent: 'order',
            category: [
              {
                coding: [
                  system: 'http://terminology.hl7.org/CodeSystem/medicationrequest-category',
                  code: 'outpatient'
                ]
              }
            ],
            reportedBoolean: false,
            medicationReference: {
              reference: 'Medication/m1'
            },
            subject: {
              reference: 'Patient/p1',
            },
            encounter: {
              reference: 'Encounter/e1'
            },
            authoredOn: '2021-08-04T00:00:00-04:00',
            requester: {
              reference: 'Practitioner/p2'
            },
            dosageInstruction: [
              {
                text: 'this is a dosage instruction'
              }
            ]
          )
        }

        it 'passes if server suports all MS slices' do
          allow_any_instance_of(test_class)
            .to receive(:scratch_resources).and_return(
              {
                all: [medication_request_1]
              }
            )


          result = run(test_class)
          expect(result.result).to eq('pass')
        end
      end
    end
  end

  describe 'must support test for choices' do
    let(:test_class) { USCoreTestKit::USCoreV501::ConditionProblemsHealthConcernsMustSupportTest }
    let(:condition) {
      FHIR::Condition.new(
        extension: [
          {
            url: 'http://hl7.org/fhir/StructureDefinition/condition-assertedDate',
            valueDateTime: '2016-08-10'
          }
        ],
        clinicalStatus: {
          coding: [
            {
              system: 'http://terminology.hl7.org/CodeSystem/condition-clinical',
              code: 'active'
            }
          ]
        },
        verificationStatus: {
          coding: [
            {
              system: 'http://terminology.hl7.org/CodeSystem/condition-ver-status',
              code: 'confirmed'
            }
          ]
        },
        category: [
          {
            coding: [
              {
                system: 'http://terminology.hl7.org/CodeSystem/condition-category',
                code: 'problem-list-item'
              }
            ]
          },
          {
            coding: [
              {
                system: 'http://hl7.org/fhir/us/core/CodeSystem/us-core-tags',
                code: 'sdoh'
              }
            ]
          }
        ],
        code: {
          coding: [
            {
              system: 'http://snomed.info/sct',
              code: '445281000124101'
            }
          ]
        },
        subject: {
          reference: 'Patient/123',
        },
        recordedDate: '2016-08-10T07:15:07-08:00',
        onsetDateTime: '2016-08-10T07:15:07-08:00',
        abatementDateTime: '2016-08-10T07:15:07-08:00'
      )
    }

    it 'passes if server suports assertDate extension' do
      condition.onsetDateTime = nil

      allow_any_instance_of(test_class)
        .to receive(:scratch_resources).and_return(
          {
            all: [condition]
          }
        )

      result = run(test_class)
      expect(result.result).to eq('pass')
    end

    it 'passes if server suports onsetDate' do
      condition.extension = []

      allow_any_instance_of(test_class)
        .to receive(:scratch_resources).and_return(
          {
            all: [condition]
          }
        )

      result = run(test_class)
      expect(result.result).to eq('pass')
    end

    it 'skips if server suports none of assertDate extension and onsetDate' do
      condition.onsetDateTime = nil
      condition.extension = []

      allow_any_instance_of(test_class)
        .to receive(:scratch_resources).and_return(
          {
            all: [condition]
          }
        )

      result = run(test_class)
      expect(result.result).to eq('skip')
      expect(result.result_message).to include('onsetDateTime')
      expect(result.result_message).to include('Condition.extension:assertedDate')
    end
  end

  describe 'must support tests for sub elements of slices' do
    let (:test_class) {
      USCoreTestKit::USCoreV610::CoverageMustSupportTest
    }
    let (:group_class) {
      FHIR::Coverage::Class.new.tap{ |loc_class|
        loc_class.type = FHIR::CodeableConcept.new.tap{ |code_concept|
          code_concept.coding = [FHIR::Coding.new.tap{ |coding|
            coding.system = "http://terminology.hl7.org/CodeSystem/coverage-class"
            coding.code = "group"
          }]
        }
        loc_class.value = "group-class-value"
        loc_class.name = "group-class-name"
        }
    }
    let (:plan_class) {
      FHIR::Coverage::Class.new.tap{ |loc_class|
        loc_class.type = FHIR::CodeableConcept.new.tap{ |code_concept|
          code_concept.coding = [FHIR::Coding.new.tap{ |coding|
            coding.system = "http://terminology.hl7.org/CodeSystem/coverage-class"
            coding.code = "plan"
          }]
        }
      loc_class.value = "plan-class-value"
      loc_class.name = "plan-class-name"
      }
    }
    let (:coverage_with_two_classes) {
      FHIR::Coverage.new.tap{ |cov|
        cov.status = "active"
        cov.type = FHIR::CodeableConcept.new.tap{ |code_concept|
          code_concept.coding = [ FHIR::Coding.new.tap { |coding|
              coding.system = "https://nahdo.org/sopt"
              coding.code = "3712"
              coding.display = "PPO"
            },
            FHIR::Coding.new.tap { |coding|
              coding.system = "http://terminology.hl7.org/CodeSystem/v3-ActCode"
              coding.code = "PPO"
              coding.display = "preferred provider organization policy"
            }
          ],
          code_concept.text = "PPO"
        },
        cov.subscriberId = "888009335"
        cov.beneficiary = FHIR::Reference.new.tap { |ref|
          ref.reference = "Patient/example"
        }
        cov.relationship = FHIR::CodeableConcept.new.tap { |code_concept|
          code_concept.coding = [FHIR::Coding.new.tap { |coding|
              coding.system ="http://terminology.hl7.org/CodeSystem/subscriber-relationship"
              coding.code = "self"
            }
          ],
          code_concept.text = "Self"
        },
        cov.period =  FHIR::Period.new.tap { |period|
          period.start = "2020-01-01"
        }
        cov.payor = [ FHIR::Reference.new.tap { |ref|
            ref.reference = "Organization/acme-payer"
            ref.display = "Acme Health Plan"
          }
        ],
        cov.local_class = [group_class, plan_class]
        cov.identifier = [FHIR::Identifier.new.tap {|identifier|
            identifier.type = FHIR::CodeableConcept.new.tap { |code_concept|
              code_concept.coding = [FHIR::Coding.new.tap{ |coding|
                coding.system = "http://terminology.hl7.org/CodeSystem/v2-0203"
                coding.code = "MB"
              }]
            }
            identifier.system = "https://github.com/inferno-framework/us-core-test-kit"
            identifier.value = "f4a375d2-4e53-4f81-ba95-345e7573b550"
          }
        ] 
      }
    }

    it 'passes if resources cover all must support sub elements of slices' do
      allow_any_instance_of(test_class)
          .to receive(:scratch_resources).and_return(
            {
              all: [coverage_with_two_classes]
            }
          )
        result = run(test_class)
        expect(result.result).to eq('pass')
    end

    it 'skips if resources do not cover all must support sub elements of slices' do
      coverage_with_just_group = coverage_with_two_classes.dup
      coverage_with_just_group.local_class = [group_class]
      allow_any_instance_of(test_class)
          .to receive(:scratch_resources).and_return(
            {
              all: [coverage_with_just_group]
            }
          )

        result = run(test_class)
        expect(result.result).to eq('skip')
    end

    it 'passes if resources cover all must support elements over multiple elements' do
      coverage_with_just_group = coverage_with_two_classes.clone
      coverage_with_just_group.local_class = [group_class]
      coverage_with_just_plan = coverage_with_two_classes.clone
      coverage_with_just_plan.local_class = [plan_class]
      allow_any_instance_of(test_class)
          .to receive(:scratch_resources).and_return(
            {
              all: [coverage_with_just_group, coverage_with_just_plan]
            }
          )

        result = run(test_class)
        expect(result.result).to eq('pass')
    end
  end

end
