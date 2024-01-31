RSpec.describe USCoreTestKit::SearchTest do
  let(:suite) { Inferno::Repositories::TestSuites.new.find('us_core_v311') }
  let(:session_data_repo) { Inferno::Repositories::SessionData.new }
  let(:test_session) { repo_create(:test_session, test_suite_id: suite.id) }
  let(:url) { 'http://example.com/fhir' }
  let(:error_outcome) { FHIR::OperationOutcome.new(issue: [{ severity: 'error' }]) }

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

  describe 'search requiring status' do
    let(:status_search_test) do
      Class.new(Inferno::Test) do
        include USCoreTestKit::SearchTest

        def properties
          @properties ||= USCoreTestKit::SearchTestProperties.new(
            resource_type: 'Observation',
            search_param_names: ['patient'],
            possible_status_search: true
          )
        end

        def self.metadata
          @metadata ||=
            USCoreTestKit::Generator::GroupMetadata.new(
              YAML.load_file(
                File.join(
                  __dir__,
                  '..',
                  'fixtures',
                  'status_search_metadata.yml'
                )
              )
            )
        end

        def scratch_resources
          scratch[:bodyheight_resources] ||= {}
        end

        fhir_client { url :url }
        input :url, :patient_ids

        run do
          run_search_test
        end
      end
    end
    let(:patient_id) { '123' }
    let(:observation) do
      FHIR::Observation.new(
        status: 'final',
        category: [
          {
            coding: [
              {
                system: 'http://terminology.hl7.org/CodeSystem/observation-category',
                code: 'vital-signs'
              }
            ]
          }],
        code: [
          {
            coding: [
              {
                system: 'http://loinc.org',
                code: '8302-2'
              }
            ]
          }],
        subject: {
          reference: "Patient/#{patient_id}"
        },
      )
    end
    let(:bundle) do
      FHIR::Bundle.new(entry: [{resource: observation}])
    end

    before do
      Inferno::Repositories::Tests.new.insert(status_search_test)
      allow_any_instance_of(status_search_test)
        .to receive(:scratch_resources).and_return(
              {
                all: [observation],
                patient_id => [observation]
              }
            )
    end

    it 'passes if a 200 is received' do
      stub_request(:get, "#{url}/Observation?patient=#{patient_id}")
        .to_return(status: 200, body: bundle.to_json)

      result = run(status_search_test, patient_ids: patient_id, url: url)
      expect(result.result).to eq('pass')
    end

    it 'fails if a 400 is received with no OperationOutcome' do
      stub_request(:get, "#{url}/Observation?patient=#{patient_id}")
        .to_return(status: 400, body: bundle.to_json)

      result = run(status_search_test, patient_ids: patient_id, url: url)

      expect(result.result).to eq('fail')
      expect(result.result_message).to eq('Server returned a status of 400 without an OperationOutcome')
    end

    it 'succeeds if a 400 is received with an OperationOutcome and the status search succeeds' do
      statuses = 'registered,preliminary,final,amended,corrected,cancelled,entered-in-error,unknown'
      stub_request(:get, "#{url}/Observation?patient=#{patient_id}")
        .to_return(status: 400, body: FHIR::OperationOutcome.new.to_json)
      stub_request(:get, "#{url}/Observation?patient=#{patient_id}&status=#{statuses}")
        .to_return(status: 200, body: bundle.to_json)

      result = run(status_search_test, patient_ids: patient_id, url: url)

      expect(result.result).to eq('pass')
    end
  end

  describe 'search with Encounter status with optional multiple-or requirement' do
    let(:patient_id) { '123' }
    let(:test_class) do
      Class.new(USCoreTestKit::USCoreV400::EncounterDatePatientSearchTest) do
        fhir_client { url :url }
        input :url, :patient_ids
      end
    end
    let(:encounter) do
      FHIR::Encounter.new(
        status: 'finished',
        period: {
          start: '2021-12-08T16:35:11.000Z',
          end: '2022-02-07T17:51:00.000Z'
        },
        subject: {
          reference: "Patient/#{patient_id}"
        }
      )
    end
    let(:bundle) do
      FHIR::Bundle.new(entry: [{resource: encounter}])
    end

    before do
      allow_any_instance_of(test_class)
        .to receive(:scratch_resources).and_return(
              {
                all: [encounter],
                patient_id => [encounter]
              }
            )
    end

    it 'succeeds if a 400 is received with an OperationOutcome and the status search succeeds' do
      requests = []
      requests << stub_request(:get, "#{url}/Encounter?patient=#{patient_id}&date=gt2021-12-07T16:35:11%2B00:00")
        .to_return(status: 400, body: FHIR::OperationOutcome.new.to_json)
      requests << stub_request(:get, "#{url}/Encounter?patient=#{patient_id}&date=gt2021-12-07T16:35:11%2B00:00&status=planned")
        .to_return(status: 200, body: FHIR::Bundle.new.to_json)
      requests << stub_request(:get, "#{url}/Encounter?patient=#{patient_id}&date=gt2021-12-07T16:35:11%2B00:00&status=arrived")
        .to_return(status: 200, body: FHIR::Bundle.new.to_json)
      requests << stub_request(:get, "#{url}/Encounter?patient=#{patient_id}&date=gt2021-12-07T16:35:11%2B00:00&status=triaged")
        .to_return(status: 200, body: FHIR::Bundle.new.to_json)
      requests << stub_request(:get, "#{url}/Encounter?patient=#{patient_id}&date=gt2021-12-07T16:35:11%2B00:00&status=in-progress")
        .to_return(status: 200, body: FHIR::Bundle.new.to_json)
      requests << stub_request(:get, "#{url}/Encounter?patient=#{patient_id}&date=gt2021-12-07T16:35:11%2B00:00&status=onleave")
        .to_return(status: 200, body: FHIR::Bundle.new.to_json)
      requests << stub_request(:get, "#{url}/Encounter?patient=#{patient_id}&date=gt2021-12-07T16:35:11%2B00:00&status=finished")
        .to_return(status: 200, body: FHIR::Bundle.new.to_json)
      requests << stub_request(:get, "#{url}/Encounter?patient=#{patient_id}&date=gt2021-12-07T16:35:11%2B00:00&status=cancelled")
        .to_return(status: 200, body: FHIR::Bundle.new.to_json)
      requests << stub_request(:get, "#{url}/Encounter?patient=#{patient_id}&date=gt2021-12-07T16:35:11%2B00:00&status=entered-in-error")
        .to_return(status: 200, body: FHIR::Bundle.new.to_json)
      requests << stub_request(:get, "#{url}/Encounter?patient=#{patient_id}&date=gt2021-12-07T16:35:11%2B00:00&status=unknown")
        .to_return(status: 200, body: FHIR::Bundle.new.to_json)

      result = run(test_class, patient_ids: patient_id, url: url)

      expect(result.result).to eq('skip')
      expect(requests).to all(have_been_made.once)
    end
  end

  describe 'search with medication inclusion' do
    context 'when the medication resources are contained' do
      let(:patient_id) { '123' }
      let(:medication_id) { '#abc' }
      let(:medication) { FHIR::Medication.new(id: medication_id) }
      let(:medication_request) do
        FHIR::MedicationRequest.new(
          id: 'def',
          medicationReference: {
            reference: medication_id
          },
          subject: {
            reference: "Patient/#{patient_id}"
          },
          contained: [
            medication
          ]
        )
      end
      let(:medication_request_search_test) do
        Class.new(Inferno::Test) do
          include USCoreTestKit::SearchTest

          def properties
            @properties ||= USCoreTestKit::SearchTestProperties.new(
              resource_type: 'MedicationRequest',
              search_param_names: ['patient'],
              possible_status_search: true,
              test_medication_inclusion: true,
            )
          end

          def self.metadata
            @metadata ||=
              USCoreTestKit::Generator::GroupMetadata.new(
                YAML.load_file(
                  File.join(
                    __dir__,
                    '..',
                    'fixtures',
                    'medication_inclusion_metadata.yml'
                  )
                )
              )
          end

          def scratch_resources
            scratch[:medication_request_resources] ||= {}
          end

          fhir_client { url :url }
          input :url, :patient_ids

          run do
            run_search_test
          end
        end
      end
      let(:bundle) do
        FHIR::Bundle.new(entry: [{resource: medication_request}])
      end
      let(:test_scratch) { {} }

      before do
        Inferno::Repositories::Tests.new.insert(medication_request_search_test)
        allow_any_instance_of(medication_request_search_test)
          .to receive(:scratch).and_return(test_scratch)
      end

      it 'passes without performing an _include search' do
        # Match any request that doesn't contain '_include'
        stub_request(:get, /^((?!_include).)*$/)
          .to_return(status: 200, body: bundle.to_json)

        result = run(medication_request_search_test, patient_ids: patient_id, url: url)
        expect(result.result).to eq('pass')
        expect(test_scratch[:medication_resources][:all]).to include(medication)
        expect(test_scratch[:medication_resources][:contained]).to include(medication)
        expect(test_scratch[:medication_resources][patient_id]).to include(medication)
      end
    end
  end

  describe 'search with device filtering' do
    context 'when a list of codes is provided' do
      let(:patient_id) { '123' }
      let(:implantable_device_code1) { 'code1' }
      let(:implantable_device_code2) { 'code2' }
      let(:non_implantable_device_code) { 'code3' }
      let(:device_codes) { [implantable_device_code1, implantable_device_code2, non_implantable_device_code] }
      let(:devices) do
        device_codes.map do |code|
          FHIR::Device.new(
            id: 'abc',
            patient: {
              reference: "Patient/#{patient_id}"
            },
            type: {
              coding: [{ code: code }]
            }
          )
        end
      end
      let(:test_class) do
        Class.new(USCoreTestKit::USCoreV311::DevicePatientSearchTest) do
          fhir_client { url :url }
          input :url, :patient_ids, :implantable_device_codes
        end
      end
      let(:bundle) do
        entries = devices.map do |device|
          { resource: device }
        end
        FHIR::Bundle.new(entry: entries)
      end
      let(:test_scratch) { {} }

      before do
        allow_any_instance_of(test_class)
          .to receive(:scratch).and_return(test_scratch)

        stub_request(:get, "#{url}/Device?patient=#{patient_id}")
          .to_return(status: 200, body: bundle.to_json)
        stub_request(:get, "#{url}/Device?patient=Patient/#{patient_id}")
          .to_return(status: 200, body: bundle.to_json)
        stub_request(:post, "#{url}/Device/_search")
          .with(body: {"patient"=>patient_id})
          .to_return(status: 200, body: bundle.to_json)
      end

      it 'only stores devices matching those codes' do
        implantable_devices = devices[0..1]
        non_implantable_device = devices.last
        code_input = "#{implantable_device_code1}, #{implantable_device_code2}"
        result = run(test_class, patient_ids: patient_id, url: url, implantable_device_codes: code_input)

        expect(result.result).to eq('pass')
        expect(test_scratch[:device_resources][:all]).to eq(implantable_devices)
        expect(test_scratch[:device_resources][:all]).to_not include(non_implantable_device)
      end

      it 'skips if no device matches code input' do
        code_input = 'something_else'
        result = run(test_class, patient_ids: patient_id, url: url, implantable_device_codes: code_input)

        expect(result.result).to eq('skip')
        expect(result.result_message).to include('Device Type Code filter: something_else')
      end
    end
  end

  describe 'search multiple-or' do
    let(:multiple_or_search_test) do
      Class.new(Inferno::Test) do
        include USCoreTestKit::SearchTest

        def properties
          @properties ||= USCoreTestKit::SearchTestProperties.new(
            resource_type: 'MedicationRequest',
            search_param_names: ['patient', 'intent'],
            multiple_or_search_params: ['intent']
          )
        end

        def self.metadata
          @metadata ||=
            USCoreTestKit::Generator::GroupMetadata.new(
              YAML.load_file(
                File.join(
                  __dir__,
                  '..',
                  'fixtures',
                  'medication_inclusion_metadata.yml'
                )
              )
            )
        end

        def scratch_resources
          scratch[:medication_request] ||= {}
        end

        fhir_client { url :url }
        input :url, :patient_ids

        run do
          run_search_test
        end
      end
    end
    let(:patient_id) { '123' }
    let(:intent_1) { 'order' }
    let(:intent_2) { 'plan' }
    let(:medication_request_1) do
      FHIR::MedicationRequest.new(
        status: 'active',
        intent: intent_1,
        subject: {
          reference: "Patient/#{patient_id}"
        }
      )
    end
    let(:medication_request_2) do
      FHIR::MedicationRequest.new(
        status: 'active',
        intent: intent_2,
        subject: {
          reference: "Patient/#{patient_id}"
        }
      )
    end
    let(:bundle_1) do
      FHIR::Bundle.new(entry: [{resource: medication_request_1}])
    end
    let(:bundle_2) do
      FHIR::Bundle.new(entry: [{resource: medication_request_2}])
    end

    before do
      Inferno::Repositories::Tests.new.insert(multiple_or_search_test)
      allow_any_instance_of(multiple_or_search_test)
        .to receive(:scratch_resources).and_return(
              {
                all: [medication_request_1, medication_request_2],
                patient_id => [medication_request_1, medication_request_2]
              }
            )
    end

    it 'fails if multiple-or search test does not return all existing values' do
      stub_request(:get, "#{url}/MedicationRequest?patient=#{patient_id}&intent=#{intent_1}")
        .to_return(status: 200, body: bundle_1.to_json)
      stub_request(:get, "#{url}/MedicationRequest?patient=#{patient_id}&intent=proposal,plan,order,original-order,reflex-order,filler-order,instance-order,option")
        .to_return(status: 200, body: bundle_2.to_json)
      result = run(multiple_or_search_test, patient_ids: patient_id, url: url)

      expect(result.result).to eq('fail')
      expect(result.result_message).to eq("Could not find order values from intent in any of the resources returned for Patient/#{patient_id}")
    end
  end

  describe 'search date/dateTime precision' do
    let(:patient_id) { '123' }
    context 'with date precision' do
      let(:test_class) do
        Class.new(USCoreTestKit::USCoreV400::GoalPatientTargetDateSearchTest) do
          fhir_client { url :url }
          input :url
        end
      end
      let(:goal_year) do
        FHIR::Goal.new(
          id: 'year',
          subject: {
            reference: "Patient/#{patient_id}"
          },
          target: [
            { dueDate: '2020' }
          ]
        )
      end
      let(:goal_date) do
        FHIR::Goal.new(
          id: 'date',
          subject: {
            reference: "Patient/#{patient_id}"
          },
          target: [
            { dueDate: '2020-03-04' }
          ]
        )
      end
      let(:goal_datetime) do
          FHIR::Goal.new(
            id: 'datetime',
            subject: {
              reference: "Patient/#{patient_id}"
            },
            target: [
              { dueDate: '2020-03-04T13:01:01-04:00' }
            ]
          )
      end

      let(:bundle_year) { FHIR::Bundle.new(entry: [ {resource: goal_year} ]) }
      let(:bundle_date) { FHIR::Bundle.new(entry: [ {resource: goal_date} ]) }
      let(:bundle_datetime) { FHIR::Bundle.new(entry: [ {resource: goal_datetime} ]) }

      it 'uses comparator search if value is year' do
        allow_any_instance_of(test_class)
          .to receive(:scratch_resources).and_return(
            {
              all: [goal_year],
              patient_id => [goal_year]
            }
          )

        request = stub_request(:get, "#{url}/Goal?patient=#{patient_id}&target-date=2020")
          .to_return(status: 200, body: bundle_year.to_json)

        stub_request(:get, "#{url}/Goal?patient=#{patient_id}&target-date=gt2019-12-31T00:00:00%2B00:00")
          .to_return(status: 200, body: bundle_year.to_json)
        stub_request(:get, "#{url}/Goal?patient=#{patient_id}&target-date=ge2019-12-31T00:00:00%2B00:00")
          .to_return(status: 200, body: bundle_year.to_json)
        stub_request(:get, "#{url}/Goal?patient=#{patient_id}&target-date=lt2020-01-02T00:00:00%2B00:00")
          .to_return(status: 200, body: bundle_year.to_json)
        stub_request(:get, "#{url}/Goal?patient=#{patient_id}&target-date=le2020-01-02T00:00:00%2B00:00")
          .to_return(status: 200, body: bundle_year.to_json)

        result = run(test_class, patient_ids: patient_id, url: url)
        expect(request).not_to have_been_made
        expect(result.result).to eq('pass')
      end

      it 'searches date if value is date' do
        allow_any_instance_of(test_class)
          .to receive(:scratch_resources).and_return(
            {
              all: [goal_date],
              patient_id => [goal_date]
            }
          )

        request = stub_request(:get, "#{url}/Goal?patient=#{patient_id}&target-date=2020-03-04")
          .to_return(status: 200, body: bundle_date.to_json)

        stub_request(:get, "#{url}/Goal?patient=#{patient_id}&target-date=gt2020-03-03T00:00:00%2B00:00")
          .to_return(status: 200, body: bundle_date.to_json)
        stub_request(:get, "#{url}/Goal?patient=#{patient_id}&target-date=ge2020-03-03T00:00:00%2B00:00")
          .to_return(status: 200, body: bundle_date.to_json)
        stub_request(:get, "#{url}/Goal?patient=#{patient_id}&target-date=lt2020-03-05T00:00:00%2B00:00")
          .to_return(status: 200, body: bundle_date.to_json)
        stub_request(:get, "#{url}/Goal?patient=#{patient_id}&target-date=le2020-03-05T00:00:00%2B00:00")
          .to_return(status: 200, body: bundle_date.to_json)

        result = run(test_class, patient_ids: patient_id, url: url)
        expect(request).to have_been_made.once
        expect(result.result).to eq('pass')
      end

      it 'searches second+offset if value is dateTime' do
        allow_any_instance_of(test_class)
          .to receive(:scratch_resources).and_return(
            {
              all: [goal_datetime],
              patient_id => [goal_datetime]
            }
          )

        request = stub_request(:get, "#{url}/Goal?patient=#{patient_id}&target-date=2020-03-04T13:01:01-04:00")
          .to_return(status: 200, body: bundle_datetime.to_json)

        stub_request(:get, "#{url}/Goal?patient=#{patient_id}&target-date=gt2020-03-03T13:01:01-04:00")
          .to_return(status: 200, body: bundle_datetime.to_json)
        stub_request(:get, "#{url}/Goal?patient=#{patient_id}&target-date=ge2020-03-03T13:01:01-04:00")
          .to_return(status: 200, body: bundle_datetime.to_json)
        stub_request(:get, "#{url}/Goal?patient=#{patient_id}&target-date=lt2020-03-05T13:01:01-04:00")
          .to_return(status: 200, body: bundle_datetime.to_json)
        stub_request(:get, "#{url}/Goal?patient=#{patient_id}&target-date=le2020-03-05T13:01:01-04:00")
          .to_return(status: 200, body: bundle_datetime.to_json)

        result = run(test_class, patient_ids: patient_id, url: url)
        expect(request).to have_been_made.once
        expect(result.result).to eq('pass')
      end
    end

    context 'with dateTime precision' do
      let(:test_class) do
        Class.new(USCoreTestKit::USCoreV400::ImmunizationPatientDateSearchTest) do
          fhir_client { url :url }
          input :url
        end
      end
      let(:immunization_year) do
        FHIR::Immunization.new(
          id: 'year',
          patient: {
            reference: "Patient/#{patient_id}"
          },
          occurrenceDateTime: '2020'
        )
      end
      let(:immunization_date) do
        FHIR::Immunization.new(
          id: 'date',
          patient: {
            reference: "Patient/#{patient_id}"
          },
          occurrenceDateTime: '2020-03-04'
        )
      end
      let(:immunization_datetime) do
          FHIR::Immunization.new(
            id: 'datetime',
            patient: {
              reference: "Patient/#{patient_id}"
            },
            occurrenceDateTime: '2020-03-04T13:01:01-04:00'
          )
      end

      let(:bundle_year) { FHIR::Bundle.new(entry: [ {resource: immunization_year} ]) }
      let(:bundle_date) { FHIR::Bundle.new(entry: [ {resource: immunization_date} ]) }
      let(:bundle_datetime) { FHIR::Bundle.new(entry: [ {resource: immunization_datetime} ]) }

      it 'uses comparator search if value is year' do
        allow_any_instance_of(test_class)
          .to receive(:scratch_resources).and_return(
            {
              all: [immunization_year],
              patient_id => [immunization_year]
            }
          )

        request = stub_request(:get, "#{url}/Immunization?patient=#{patient_id}&date=2020")
          .to_return(status: 200, body: bundle_year.to_json)

        stub_request(:get, "#{url}/Immunization?patient=#{patient_id}&date=gt2019-12-31T00:00:00%2B00:00")
          .to_return(status: 200, body: bundle_year.to_json)
        stub_request(:get, "#{url}/Immunization?patient=#{patient_id}&date=ge2019-12-31T00:00:00%2B00:00")
          .to_return(status: 200, body: bundle_year.to_json)
        stub_request(:get, "#{url}/Immunization?patient=#{patient_id}&date=lt2020-01-02T00:00:00%2B00:00")
          .to_return(status: 200, body: bundle_year.to_json)
        stub_request(:get, "#{url}/Immunization?patient=#{patient_id}&date=le2020-01-02T00:00:00%2B00:00")
          .to_return(status: 200, body: bundle_year.to_json)

        result = run(test_class, patient_ids: patient_id, url: url)
        expect(request).not_to have_been_made
        expect(result.result).to eq('pass')
      end

      it 'uses comparator search if value is date' do
        allow_any_instance_of(test_class)
          .to receive(:scratch_resources).and_return(
            {
              all: [immunization_date],
              patient_id => [immunization_date]
            }
          )

        request = stub_request(:get, "#{url}/Immunization?patient=#{patient_id}&date=2020-03-04")
          .to_return(status: 200, body: bundle_date.to_json)

        stub_request(:get, "#{url}/Immunization?patient=#{patient_id}&date=gt2020-03-03T00:00:00%2B00:00")
          .to_return(status: 200, body: bundle_date.to_json)
        stub_request(:get, "#{url}/Immunization?patient=#{patient_id}&date=ge2020-03-03T00:00:00%2B00:00")
          .to_return(status: 200, body: bundle_date.to_json)
        stub_request(:get, "#{url}/Immunization?patient=#{patient_id}&date=lt2020-03-05T00:00:00%2B00:00")
          .to_return(status: 200, body: bundle_date.to_json)
        stub_request(:get, "#{url}/Immunization?patient=#{patient_id}&date=le2020-03-05T00:00:00%2B00:00")
          .to_return(status: 200, body: bundle_date.to_json)

        result = run(test_class, patient_ids: patient_id, url: url)
        expect(request).not_to have_been_made.once
        expect(result.result).to eq('pass')
      end

      it 'searches second+offset if value is dateTime' do
        allow_any_instance_of(test_class)
          .to receive(:scratch_resources).and_return(
            {
              all: [immunization_datetime],
              patient_id => [immunization_datetime]
            }
          )

        request = stub_request(:get, "#{url}/Immunization?patient=#{patient_id}&date=2020-03-04T13:01:01-04:00")
          .to_return(status: 200, body: bundle_datetime.to_json)

        stub_request(:get, "#{url}/Immunization?patient=#{patient_id}&date=gt2020-03-03T13:01:01-04:00")
          .to_return(status: 200, body: bundle_datetime.to_json)
        stub_request(:get, "#{url}/Immunization?patient=#{patient_id}&date=ge2020-03-03T13:01:01-04:00")
          .to_return(status: 200, body: bundle_datetime.to_json)
        stub_request(:get, "#{url}/Immunization?patient=#{patient_id}&date=lt2020-03-05T13:01:01-04:00")
          .to_return(status: 200, body: bundle_datetime.to_json)
        stub_request(:get, "#{url}/Immunization?patient=#{patient_id}&date=le2020-03-05T13:01:01-04:00")
          .to_return(status: 200, body: bundle_datetime.to_json)

        result = run(test_class, patient_ids: patient_id, url: url)
        expect(request).to have_been_made.once
        expect(result.result).to eq('pass')
      end
    end
  end

  describe '#all_search_params' do
    let(:test_class) { USCoreTestKit::USCoreV311::DocumentReferencePatientCategoryDateSearchTest }
    let(:test) { test_class.new }
    let(:patient_id) {'123'}
    let(:patient_no_resource) {'no-resource'}
    let(:category_code) {'clinical-note'}
    let(:date) {'2020-05-14T11:02:00+05:00'}
    let(:resource_with_category_date) {
      FHIR::DocumentReference.new(
        subject: {
          reference: "Patient/#{patient_id}"
        },
        category: [
          {
            coding: [
              {
                code: category_code
              }
            ]
          }
        ],
        date: date
      )
    }

    before do
      allow_any_instance_of(test_class)
        .to receive(:scratch_resources).and_return(
          {
            patient_no_resource => [],
            patient_id => [resource_with_category_date]
          }
        )
      allow_any_instance_of(test_class)
        .to receive(:patient_id_list).and_return([patient_no_resource, patient_id])
    end

    it 'handles patient with or without resources' do
      params = test.all_search_params

      expect(params).not_to be_empty
      expect(params[patient_no_resource]).to be_empty
      expect(params[patient_id]).not_to be_empty
    end
  end

  describe '#search_params_with_values' do
    let(:test_class) { USCoreTestKit::USCoreV311::DocumentReferencePatientCategoryDateSearchTest }
    let(:test) { test_class.new }
    let(:patient_id) {'123'}
    let(:patient_no_resource) {'456'}
    let(:category_code) {'something-else'}
    let(:date) {'2020-05-14T11:02:00+05:00'}
    let(:resource_with_category) {
      FHIR::DocumentReference.new(
        subject: {
          reference: "Patient/#{patient_id}"
        },
        category: [
          {
            coding: [
              {
                code: 'clinical-note'
              }
            ]
          }
        ]
      )
    }
    let(:resource_with_category_date) {
      FHIR::DocumentReference.new(
        subject: {
          reference: "Patient/#{patient_id}"
        },
        category: [
          {
            coding: [
              {
                code: category_code
              }
            ]
          }
        ],
        date: date
      )
    }

    it 'returns search values from the same resource' do
      allow_any_instance_of(test_class)
        .to receive(:scratch_resources_for_patient).and_return([
          resource_with_category,
          resource_with_category_date
        ])

      params = test.search_params_with_values(test.search_param_names, patient_id)

      expect(params).not_to be_empty
      expect(params['patient']).to eq(patient_id)
      expect(params['category']).to eq(category_code)
      expect(params['date']).to eq(date)
    end

    it 'handles patient without resources' do
      allow_any_instance_of(test_class)
        .to receive(:scratch_resources_for_patient).and_return([])

      patient_id = 'no_resource'

      params = test.search_params_with_values(test.search_param_names, patient_id)

      expect(params).not_to be_empty
      expect(params['patient']).to eq(patient_id)
      expect(params['category']).to be_nil
      expect(params['date']).to be_nil
    end
  end

  describe '#search_param_value' do
    context 'Array element having DAR extension' do
      let(:test_class) { USCoreTestKit::USCoreV311::PatientNameSearchTest }
      let(:test) { test_class.new }
      let(:search_value) {'family_name'}
      let(:patient) {
        FHIR::Patient.new(
          name: [
            {
              extension: [
                {
                  url: 'http://hl7.org/fhir/StructureDefinition/data-absent-reason',
                  valueCode: 'unknown'
                }
              ]
            },
            {
              family: search_value,
              given: [
                'first_name'
              ]
            }
          ]
        )
      }

      it 'returns search value from the first none-DAR name of name array' do
        element = test.search_param_value('name', Array.wrap(patient))

        expect(element).to eq(search_value)
      end
    end

    context 'CodeablcConcept with text only' do
      let(:test_class) { USCoreTestKit::USCoreV311::DiagnosticReportLabPatientCategorySearchTest }
      let(:test) { test_class.new }

      it 'returns nil if category has text only' do
        diagnostic_report = FHIR::DiagnosticReport.new(
          category: [
            {
              text: 'Lab Report'
            }
          ]
        )

        element = test.search_param_value('category', Array.wrap(diagnostic_report))

        expect(element).to be_nil
      end

      it 'returns code value if category has one coding with code' do
        diagnostic_report = FHIR::DiagnosticReport.new(
          category: [
            {
              text: 'This is a display text'
            },
            {
              coding: [
                {
                  display: 'This is a display text'
                },
                {
                  code: 'LAB',
                  system: 'http://terminology.hl7.org/CodeSystem/v2-0074'
                }
              ]
            }
          ]
        )

        element = test.search_param_value('category', Array.wrap(diagnostic_report))
        element_with_system = test.search_param_value('category', Array.wrap(diagnostic_report), include_system: true)

        expect(element).to eq('LAB')
        expect(element_with_system).to eq('http://terminology.hl7.org/CodeSystem/v2-0074|LAB')
      end
    end
  end

  describe '#perform_comparator_searches' do
    let(:test_class) do
      Class.new(USCoreTestKit::USCoreV311::ImmunizationPatientDateSearchTest) do
        fhir_client { url :url }
        input :url
      end
    end
    let(:test) { test_class.new }
    let(:patient_id) { '85' }
    let(:immunization) {
      FHIR::Immunization.new(
        id: 'datetime',
        patient: {
          reference: "Patient/#{patient_id}"
        },
        occurrenceDateTime: '2020-03-04T13:01:01-04:00'
      )
    }
    let(:bundle) {
      FHIR::Bundle.new(
        entry: [
          { resource: immunization },
          { resource: FHIR::OperationOutcome.new }
        ]
      )
    }

    it 'passes with additional OperationOutcome entry' do
      allow_any_instance_of(test_class)
        .to receive(:scratch_resources_for_patient)
        .and_return([immunization])

      stub_request(:get, "#{url}/Immunization?patient=#{patient_id}&date=2020-03-04T13:01:01-04:00")
        .to_return(status: 200, body: bundle.to_json)
      stub_request(:get, "#{url}/Immunization?patient=#{patient_id}&date=gt2020-03-03T13:01:01-04:00")
        .to_return(status: 200, body: bundle.to_json)
      stub_request(:get, "#{url}/Immunization?patient=#{patient_id}&date=ge2020-03-03T13:01:01-04:00")
        .to_return(status: 200, body: bundle.to_json)
      stub_request(:get, "#{url}/Immunization?patient=#{patient_id}&date=lt2020-03-05T13:01:01-04:00")
        .to_return(status: 200, body: bundle.to_json)
      stub_request(:get, "#{url}/Immunization?patient=#{patient_id}&date=le2020-03-05T13:01:01-04:00")
        .to_return(status: 200, body: bundle.to_json)

      result = run(test_class, patient_ids: patient_id, url: url)
      expect(result.result).to eq('pass')
    end
  end

  describe 'search_value contains comma' do
    let(:test_class) do
      Class.new(USCoreTestKit::USCoreV311::DiagnosticReportNotePatientCategoryDateSearchTest) do
        fhir_client { url :url }
        input :url
      end
    end
    let(:test) { test_class.new }
    let(:patient_id) { '85' }
    let(:diagnostic_report) {
      FHIR::DiagnosticReport.new(
        id: '1',
        subject: {
          reference: "Patient/#{patient_id}"
        },
        category: [
          {
            "coding":
            [
              {
                "system": "urn:oid:1.2.840.114350.1.13.1545.1.7.10.798268.30",
                "code": "Path,Cyt"
              }
            ]
          }
        ],
        effectiveDateTime: '2021-11-24T15:55:00Z',
      )
    }
    let(:bundle) {
      FHIR::Bundle.new(
        entry: [
          { resource: diagnostic_report }
        ]
      )
    }

    it 'passes with comma in search value' do
      allow_any_instance_of(test_class)
        .to receive(:scratch_resources_for_patient)
        .and_return([diagnostic_report])

      stub_request(:get, "#{url}/DiagnosticReport?patient=#{patient_id}&category=Path%5C,Cyt&date=2021-11-24T15:55:00Z")
        .to_return(status: 200, body: bundle.to_json)
      stub_request(:get, "#{url}/DiagnosticReport?patient=#{patient_id}&category=Path%5C,Cyt&date=gt2021-11-23T15:55:00%2B00:00")
        .to_return(status: 200, body: bundle.to_json)
      stub_request(:get, "#{url}/DiagnosticReport?patient=#{patient_id}&category=Path%5C,Cyt&date=ge2021-11-23T15:55:00%2B00:00")
        .to_return(status: 200, body: bundle.to_json)
      stub_request(:get, "#{url}/DiagnosticReport?patient=#{patient_id}&category=Path%5C,Cyt&date=lt2021-11-25T15:55:00%2B00:00")
        .to_return(status: 200, body: bundle.to_json)
      stub_request(:get, "#{url}/DiagnosticReport?patient=#{patient_id}&category=Path%5C,Cyt&date=le2021-11-25T15:55:00%2B00:00")
        .to_return(status: 200, body: bundle.to_json)
      stub_request(:get, "#{url}/DiagnosticReport?patient=#{patient_id}&category=urn:oid:1.2.840.114350.1.13.1545.1.7.10.798268.30%7CPath%5C,Cyt&date=2021-11-24T15:55:00Z")
        .to_return(status: 200, body: bundle.to_json)

      result = run(test_class, patient_ids: patient_id, url: url)
      expect(result.result).to eq('pass')
    end
  end

  describe 'search extension' do
    let(:test_class) do
      Class.new(USCoreTestKit::USCoreV501::ConditionEncounterDiagnosisPatientAssertedDateSearchTest) do
        fhir_client { url :url }
        input :url
      end
    end
    let(:test) { test_class.new }
    let(:patient_id) { '85' }
    let(:condition) {
      FHIR::Condition.new(
        id: '1',
        extension: [
          {
            url: 'http://hl7.org/fhir/StructureDefinition/condition-assertedDate',
            valueDateTime: '2021-11-24T15:55:00Z'
          }
        ],
        subject: {
          reference: "Patient/#{patient_id}"
        },
        category: [
          {
            coding: [
              {
                system: 'http://terminology.hl7.org/CodeSystem/condition-category',
                code: 'encounter-diagnosis'
              }
            ]
          }
        ]
      )
    }
    let(:bundle) {
      FHIR::Bundle.new(
        entry: [
          { resource: condition }
        ]
      )
    }

    it 'allows searching in extension' do
      allow_any_instance_of(test_class)
        .to receive(:scratch_resources_for_patient)
        .and_return([condition])

        stub_request(:get, "#{url}/Condition?patient=#{patient_id}&asserted-date=2021-11-24T15:55:00Z")
        .to_return(status: 200, body: bundle.to_json)
      stub_request(:get, "#{url}/Condition?patient=#{patient_id}&asserted-date=gt2021-11-23T15:55:00%2B00:00")
        .to_return(status: 200, body: bundle.to_json)
      stub_request(:get, "#{url}/Condition?patient=#{patient_id}&asserted-date=ge2021-11-23T15:55:00%2B00:00")
        .to_return(status: 200, body: bundle.to_json)
      stub_request(:get, "#{url}/Condition?patient=#{patient_id}&asserted-date=lt2021-11-25T15:55:00%2B00:00")
        .to_return(status: 200, body: bundle.to_json)
      stub_request(:get, "#{url}/Condition?patient=#{patient_id}&asserted-date=le2021-11-25T15:55:00%2B00:00")
        .to_return(status: 200, body: bundle.to_json)

      result = run(test_class, patient_ids: patient_id, url: url)
      expect(result.result).to eq('pass')
    end
  end

  describe '#test_medication_inclusion' do
    let(:test_class) do
      Class.new(USCoreTestKit::USCoreV311::MedicationRequestPatientIntentSearchTest) do
        fhir_client { url :url }
        input :url
      end
    end
    let(:test) { test_class.new }
    let(:patient_id) { '85' }
    let(:test_scratch) { {} }
    let(:intent) { 'order' }
    let(:medication_request_1) {
      FHIR::MedicationRequest.new(
        id: 'medication-request-local-reference',
        subject: {
          reference: "Patient/#{patient_id}"
        },
        intent: intent,
        medicationReference: {
          reference: 'Medication/medication-1'
        }
      )
    }
    let(:medication_request_2) {
      FHIR::MedicationRequest.new(
        id: 'medication-request-url',
        subject: {
          reference: "Patient/#{patient_id}"
        },
        intent: intent,
        medicationReference: {
          reference: 'http://example.com/Medication/medication-2'
        }
      )
    }
    let(:medication_requests) {
      [
        medication_request_1,
        medication_request_2
      ]
    }
    let(:medication_1) {
      FHIR::Medication.new(
        id: 'medication-1'
      )
    }
    let(:medication_2) {
      FHIR::Medication.new(
        id: 'medication-2'
      )
    }
    let(:medication_3) {
      FHIR::Medication.new(
        id: 'medication-3'
      )
    }
    let(:bundle) {
      FHIR::Bundle.new(
        entry: [
          { resource: medication_request_1 },
          { resource: medication_request_2 }
        ]
      )
    }

    before do
      allow_any_instance_of(test_class)
        .to receive(:scratch).and_return(test_scratch)

      stub_request(:get, "#{url}/MedicationRequest?patient=#{patient_id}&intent=proposal")
        .to_return(status: 200, body: FHIR::Bundle.new.to_json)
      stub_request(:get, "#{url}/MedicationRequest?patient=#{patient_id}&intent=plan")
        .to_return(status: 200, body: FHIR::Bundle.new.to_json)
      stub_request(:get, "#{url}/MedicationRequest?patient=#{patient_id}&intent=original-order")
        .to_return(status: 200, body: FHIR::Bundle.new.to_json)
      stub_request(:get, "#{url}/MedicationRequest?patient=#{patient_id}&intent=reflex-order")
        .to_return(status: 200, body: FHIR::Bundle.new.to_json)
      stub_request(:get, "#{url}/MedicationRequest?patient=#{patient_id}&intent=filler-order")
        .to_return(status: 200, body: FHIR::Bundle.new.to_json)
      stub_request(:get, "#{url}/MedicationRequest?patient=#{patient_id}&intent=instance-order")
        .to_return(status: 200, body: FHIR::Bundle.new.to_json)
      stub_request(:get, "#{url}/MedicationRequest?patient=#{patient_id}&intent=option")
        .to_return(status: 200, body: FHIR::Bundle.new.to_json)
      stub_request(:get, "#{url}/MedicationRequest?patient=#{patient_id}&intent=order")
        .to_return(status: 200, body: bundle.to_json)
      stub_request(:post, "#{url}/MedicationRequest/_search")
        .with(body: {patient: patient_id, intent: 'order'})
        .to_return(status: 200, body: bundle.to_json)
      stub_request(:get, "#{url}/MedicationRequest?patient=Patient/#{patient_id}&intent=order")
        .to_return(status: 200, body: bundle.to_json)
      stub_request(:get, "#{url}/MedicationRequest?patient=#{patient_id}&intent=proposal,plan,order,original-order,reflex-order,filler-order,instance-order,option")
        .to_return(status: 200, body: bundle.to_json)
    end

    it 'passes when references and included Medications are exact match' do
      bundle.entry.concat([ {resource: medication_1 }, {resource: medication_2}])
      stub_request(:get, "#{url}/MedicationRequest?_include=MedicationRequest:medication&intent=#{intent}&patient=#{patient_id}")
        .to_return(status: 200, body: bundle.to_json)

      result = run(test_class, patient_ids: patient_id, url: url)
      expect(result.result).to eq('pass')
    end

    it 'passes when there are more references than included Medications' do
      bundle.entry.concat([ {resource: medication_1 }])
      stub_request(:get, "#{url}/MedicationRequest?_include=MedicationRequest:medication&intent=#{intent}&patient=#{patient_id}")
        .to_return(status: 200, body: bundle.to_json)

      result = run(test_class, patient_ids: patient_id, url: url)
      expect(result.result).to eq('pass')
    end

    it 'fails when there are less references than included Medications' do
      bundle.entry.concat([ {resource: medication_1}, {resource: medication_2}, {resource: medication_3 }])
      stub_request(:get, "#{url}/MedicationRequest?_include=MedicationRequest:medication&intent=#{intent}&patient=#{patient_id}")
        .to_return(status: 200, body: bundle.to_json)

      result = run(test_class, patient_ids: patient_id, url: url)
      expect(result.result).to eq('fail')
      expect(result.result_message).to include(medication_3.id)
    end
  end

  describe '#is_reference_match' do
    let(:test_class) { USCoreTestKit::USCoreV311::MedicationRequestPatientIntentSearchTest }
    let(:test) { test_class.new }
    let(:pattern_reference) {'Medication/1'}

    it 'handles local reference' do
      result = test.is_reference_match?('Medication/1', pattern_reference)
      expect(result).to be_truthy
    end

    it 'handles canonical url' do
      result = test.is_reference_match?('http://example.com/fhir/Medication/1', pattern_reference)
      expect(result).to be_truthy
    end

    it 'handles canonical url with history' do
      result = test.is_reference_match?('http://example.com/fhir/Medication/1/_history/1', pattern_reference)
      expect(result).to be_truthy
    end

    it 'handles canonical url with version' do
      result = test.is_reference_match?('http://example.com/fhir/Medication/1|1.0', pattern_reference)
      expect(result).to be_truthy
    end

    it 'handles resource id correctly' do
      result = test.is_reference_match?('http://example.com/fhir/Medication/12', pattern_reference)
      expect(result).to be_falsey
    end
  end
end
