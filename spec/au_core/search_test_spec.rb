# frozen_string_literal: true

RSpec.describe AUCoreTestKit::SearchTest do
  let(:suite) { Inferno::Repositories::TestSuites.new.find('au_core_v100_ballot') }
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
        name:,
        value:,
        type: runnable.config.input_type(name)
      )
    end
    Inferno::TestRunner.new(test_session:, test_run:).run(runnable)
  end

  # TODO: Fix it
  # describe 'search requiring status' do
  #   let(:status_search_test) do
  #     Class.new(Inferno::Test) do
  #       include AUCoreTestKit::SearchTest

  #       def properties
  #         @properties ||= AUCoreTestKit::SearchTestProperties.new(
  #           resource_type: 'Observation',
  #           search_param_names: ['patient'],
  #           possible_status_search: true
  #         )
  #       end

  #       def self.metadata
  #         @metadata ||=
  #           AUCoreTestKit::Generator::GroupMetadata.new(
  #             YAML.load_file(
  #               File.join(
  #                 __dir__,
  #                 '..',
  #                 'fixtures',
  #                 'status_search_metadata.yml'
  #               )
  #             )
  #           )
  #       end

  #       def scratch_resources
  #         scratch[:bodyheight_resources] ||= {}
  #       end

  #       fhir_client { url :url }
  #       input :url, :patient_ids

  #       run do
  #         run_search_test
  #       end
  #     end
  #   end
  #   let(:patient_id) { '123' }
  #   let(:observation) do
  #     FHIR::Observation.new(
  #       status: 'final',
  #       category: [
  #         {
  #           coding: [
  #             {
  #               system: 'http://terminology.hl7.org/CodeSystem/observation-category',
  #               code: 'vital-signs'
  #             }
  #           ]
  #         }],
  #       code: [
  #         {
  #           coding: [
  #             {
  #               system: 'http://loinc.org',
  #               code: '8302-2'
  #             }
  #           ]
  #         }],
  #       subject: {
  #         reference: "Patient/#{patient_id}"
  #       },
  #     )
  #   end
  #   let(:bundle) do
  #     FHIR::Bundle.new(entry: [{resource: observation}])
  #   end

  #   before do
  #     Inferno::Repositories::Tests.new.insert(status_search_test)
  #     allow_any_instance_of(status_search_test)
  #       .to receive(:scratch_resources).and_return(
  #             {
  #               all: [observation],
  #               patient_id => [observation]
  #             }
  #           )
  #   end

  #   it 'passes if a 200 is received' do
  #     stub_request(:get, "#{url}/Observation?patient=#{patient_id}")
  #       .to_return(status: 200, body: bundle.to_json)

  #     result = run(status_search_test, patient_ids: patient_id, url: url)
  #     expect(result.result).to eq('pass')
  #   end

  #   it 'fails if a 400 is received with no OperationOutcome' do
  #     stub_request(:get, "#{url}/Observation?patient=#{patient_id}")
  #       .to_return(status: 400, body: bundle.to_json)

  #     result = run(status_search_test, patient_ids: patient_id, url: url)

  #     expect(result.result).to eq('fail')
  #     expect(result.result_message).to eq('Server returned a status of 400 without an OperationOutcome')
  #   end

  #   it 'succeeds if a 400 is received with an OperationOutcome and the status search succeeds' do
  #     statuses = 'registered,preliminary,final,amended,corrected,cancelled,entered-in-error,unknown'
  #     stub_request(:get, "#{url}/Observation?patient=#{patient_id}")
  #       .to_return(status: 400, body: FHIR::OperationOutcome.new.to_json)
  #     stub_request(:get, "#{url}/Observation?patient=#{patient_id}&status=#{statuses}")
  #       .to_return(status: 200, body: bundle.to_json)

  #     result = run(status_search_test, patient_ids: patient_id, url: url)

  #     expect(result.result).to eq('pass')
  #   end
  # end

  # TODO: Fix it
  # describe 'search with Encounter status with optional multiple-or requirement' do
  #   let(:patient_id) { '123' }
  #   let(:test_class) do
  #     Class.new(AUCoreTestKit::AUCoreV100_BALLOT::EncounterDatePatientSearchTest) do
  #       fhir_client { url :url }
  #       input :url, :patient_ids
  #     end
  #   end
  #   let(:encounter) do
  #     FHIR::Encounter.new(
  #       status: 'finished',
  #       period: {
  #         start: '2021-12-08T16:35:11.000Z',
  #         end: '2022-02-07T17:51:00.000Z'
  #       },
  #       subject: {
  #         reference: "Patient/#{patient_id}"
  #       }
  #     )
  #   end
  #   let(:bundle) do
  #     FHIR::Bundle.new(entry: [{resource: encounter}])
  #   end

  #   before do
  #     allow_any_instance_of(test_class)
  #       .to receive(:scratch_resources).and_return(
  #             {
  #               all: [encounter],
  #               patient_id => [encounter]
  #             }
  #           )
  #   end

  #   it 'succeeds if a 400 is received with an OperationOutcome and the status search succeeds' do
  #     requests = []
  #     requests << stub_request(:get, "#{url}/Encounter?patient=#{patient_id}&date=gt2021-12-07T16:35:11%2B00:00")
  #       .to_return(status: 400, body: FHIR::OperationOutcome.new.to_json)
  #     requests << stub_request(:get, "#{url}/Encounter?patient=#{patient_id}&date=gt2021-12-07T16:35:11%2B00:00&status=planned")
  #       .to_return(status: 200, body: FHIR::Bundle.new.to_json)
  #     requests << stub_request(:get, "#{url}/Encounter?patient=#{patient_id}&date=gt2021-12-07T16:35:11%2B00:00&status=arrived")
  #       .to_return(status: 200, body: FHIR::Bundle.new.to_json)
  #     requests << stub_request(:get, "#{url}/Encounter?patient=#{patient_id}&date=gt2021-12-07T16:35:11%2B00:00&status=triaged")
  #       .to_return(status: 200, body: FHIR::Bundle.new.to_json)
  #     requests << stub_request(:get, "#{url}/Encounter?patient=#{patient_id}&date=gt2021-12-07T16:35:11%2B00:00&status=in-progress")
  #       .to_return(status: 200, body: FHIR::Bundle.new.to_json)
  #     requests << stub_request(:get, "#{url}/Encounter?patient=#{patient_id}&date=gt2021-12-07T16:35:11%2B00:00&status=onleave")
  #       .to_return(status: 200, body: FHIR::Bundle.new.to_json)
  #     requests << stub_request(:get, "#{url}/Encounter?patient=#{patient_id}&date=gt2021-12-07T16:35:11%2B00:00&status=finished")
  #       .to_return(status: 200, body: FHIR::Bundle.new.to_json)
  #     requests << stub_request(:get, "#{url}/Encounter?patient=#{patient_id}&date=gt2021-12-07T16:35:11%2B00:00&status=cancelled")
  #       .to_return(status: 200, body: FHIR::Bundle.new.to_json)
  #     requests << stub_request(:get, "#{url}/Encounter?patient=#{patient_id}&date=gt2021-12-07T16:35:11%2B00:00&status=entered-in-error")
  #       .to_return(status: 200, body: FHIR::Bundle.new.to_json)
  #     requests << stub_request(:get, "#{url}/Encounter?patient=#{patient_id}&date=gt2021-12-07T16:35:11%2B00:00&status=unknown")
  #       .to_return(status: 200, body: FHIR::Bundle.new.to_json)

  #     result = run(test_class, patient_ids: patient_id, url: url)

  #     expect(result.result).to eq('skip')
  #     expect(requests).to all(have_been_made.once)
  #   end
  # end

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
          include AUCoreTestKit::SearchTest

          def properties
            @properties ||= AUCoreTestKit::SearchTestProperties.new(
              resource_type: 'MedicationRequest',
              search_param_names: ['patient'],
              possible_status_search: true,
              includes: [{ 'parameter' => 'MedicationRequest:medication', 'target_resource' => 'Medication', 'paths' => ['medicationReference'] }]
            )
          end

          def self.metadata
            @metadata ||=
              AUCoreTestKit::Generator::GroupMetadata.new(
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
        FHIR::Bundle.new(entry: [{ resource: medication_request }])
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

        result = run(medication_request_search_test, patient_ids: patient_id, url:)
        expect(result.result).to eq('pass')
        expect(test_scratch[:medication_resources][:all]).to include(medication)
        expect(test_scratch[:medication_resources][:contained]).to include(medication)
        expect(test_scratch[:medication_resources][patient_id]).to include(medication)
      end
    end
  end

  # TODO: Fix it
  # describe 'search multiple-or' do
  #   let(:multiple_or_search_test) do
  #     Class.new(Inferno::Test) do
  #       include AUCoreTestKit::SearchTest

  #       def properties
  #         @properties ||= AUCoreTestKit::SearchTestProperties.new(
  #           resource_type: 'MedicationRequest',
  #           search_param_names: ['patient', 'intent'],
  #           multiple_or_search_params: ['intent']
  #         )
  #       end

  #       def self.metadata
  #         @metadata ||=
  #           AUCoreTestKit::Generator::GroupMetadata.new(
  #             YAML.load_file(
  #               File.join(
  #                 __dir__,
  #                 '..',
  #                 'fixtures',
  #                 'medication_inclusion_metadata.yml'
  #               )
  #             )
  #           )
  #       end

  #       def scratch_resources
  #         scratch[:medication_request] ||= {}
  #       end

  #       fhir_client { url :url }
  #       input :url, :patient_ids

  #       run do
  #         run_search_test
  #       end
  #     end
  #   end
  #   let(:patient_id) { '123' }
  #   let(:intent_1) { 'order' }
  #   let(:intent_2) { 'plan' }
  #   let(:medication_request_1) do
  #     FHIR::MedicationRequest.new(
  #       status: 'active',
  #       intent: intent_1,
  #       subject: {
  #         reference: "Patient/#{patient_id}"
  #       }
  #     )
  #   end
  #   let(:medication_request_2) do
  #     FHIR::MedicationRequest.new(
  #       status: 'active',
  #       intent: intent_2,
  #       subject: {
  #         reference: "Patient/#{patient_id}"
  #       }
  #     )
  #   end
  #   let(:bundle_1) do
  #     FHIR::Bundle.new(entry: [{resource: medication_request_1}])
  #   end
  #   let(:bundle_2) do
  #     FHIR::Bundle.new(entry: [{resource: medication_request_2}])
  #   end

  #   before do
  #     Inferno::Repositories::Tests.new.insert(multiple_or_search_test)
  #     allow_any_instance_of(multiple_or_search_test)
  #       .to receive(:scratch_resources).and_return(
  #             {
  #               all: [medication_request_1, medication_request_2],
  #               patient_id => [medication_request_1, medication_request_2]
  #             }
  #           )
  #   end

  #   it 'fails if multiple-or search test does not return all existing values' do
  #     stub_request(:get, "#{url}/MedicationRequest?patient=#{patient_id}&intent=#{intent_1}")
  #       .to_return(status: 200, body: bundle_1.to_json)
  #     stub_request(:get, "#{url}/MedicationRequest?patient=#{patient_id}&intent=proposal,plan,order,original-order,reflex-order,filler-order,instance-order,option")
  #       .to_return(status: 200, body: bundle_2.to_json)
  #     result = run(multiple_or_search_test, patient_ids: patient_id, url: url)

  #     expect(result.result).to eq('fail')
  #     expect(result.result_message).to eq("Could not find order values from intent in any of the resources returned for Patient/#{patient_id}")
  #   end
  # end

  describe '#search_param_value' do
    context 'Array element having DAR extension' do
      let(:test_class) { AUCoreTestKit::AUCoreV100_BALLOT::PatientNameSearchTest }
      let(:test) { test_class.new }
      let(:search_value) { 'family_name' }
      let(:patient) do
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
      end

      it 'returns search value from the first none-DAR name of name array' do
        element = test.search_param_value('name', Array.wrap(patient))

        expect(element).to eq(search_value)
      end
    end
  end

  # TODO: Fix it
  # describe '#perform_comparator_searches' do
  #   let(:test_class) do
  #     Class.new(AUCoreTestKit::AUCoreV100_BALLOT::ImmunizationPatientDateSearchTest) do
  #       fhir_client { url :url }
  #       input :url
  #     end
  #   end
  #   let(:test) { test_class.new }
  #   let(:patient_id) { '85' }
  #   let(:immunization) {
  #     FHIR::Immunization.new(
  #       id: 'datetime',
  #       patient: {
  #         reference: "Patient/#{patient_id}"
  #       },
  #       occurrenceDateTime: '2020-03-04T13:01:01-04:00'
  #     )
  #   }
  #   let(:bundle) {
  #     FHIR::Bundle.new(
  #       entry: [
  #         { resource: immunization },
  #         { resource: FHIR::OperationOutcome.new }
  #       ]
  #     )
  #   }

  #   it 'passes with additional OperationOutcome entry' do
  #     allow_any_instance_of(test_class)
  #       .to receive(:scratch_resources_for_patient)
  #       .and_return([immunization])

  #     stub_request(:get, "#{url}/Immunization?patient=#{patient_id}&date=2020-03-04T13:01:01-04:00")
  #       .to_return(status: 200, body: bundle.to_json)
  #     stub_request(:get, "#{url}/Immunization?patient=#{patient_id}&date=gt2020-03-03T13:01:01-04:00")
  #       .to_return(status: 200, body: bundle.to_json)
  #     stub_request(:get, "#{url}/Immunization?patient=#{patient_id}&date=ge2020-03-03T13:01:01-04:00")
  #       .to_return(status: 200, body: bundle.to_json)
  #     stub_request(:get, "#{url}/Immunization?patient=#{patient_id}&date=lt2020-03-05T13:01:01-04:00")
  #       .to_return(status: 200, body: bundle.to_json)
  #     stub_request(:get, "#{url}/Immunization?patient=#{patient_id}&date=le2020-03-05T13:01:01-04:00")
  #       .to_return(status: 200, body: bundle.to_json)

  #     result = run(test_class, patient_ids: patient_id, url: url)
  #     expect(result.result).to eq('pass')
  #   end
  # end

  # TODO: Fix it
  # describe '#test_medication_inclusion' do
  #   let(:test_class) do
  #     Class.new(AUCoreTestKit::AUCoreV100_BALLOT::MedicationRequestPatientIntentSearchTest) do
  #       fhir_client { url :url }
  #       input :url
  #     end
  #   end
  #   let(:test) { test_class.new }
  #   let(:patient_id) { '85' }
  #   let(:test_scratch) { {} }
  #   let(:intent) { 'order' }
  #   let(:medication_request_1) {
  #     FHIR::MedicationRequest.new(
  #       id: 'medication-request-local-reference',
  #       subject: {
  #         reference: "Patient/#{patient_id}"
  #       },
  #       intent: intent,
  #       medicationReference: {
  #         reference: 'Medication/medication-1'
  #       }
  #     )
  #   }
  #   let(:medication_request_2) {
  #     FHIR::MedicationRequest.new(
  #       id: 'medication-request-url',
  #       subject: {
  #         reference: "Patient/#{patient_id}"
  #       },
  #       intent: intent,
  #       medicationReference: {
  #         reference: 'http://example.com/Medication/medication-2'
  #       }
  #     )
  #   }
  #   let(:medication_requests) {
  #     [
  #       medication_request_1,
  #       medication_request_2
  #     ]
  #   }
  #   let(:medication_1) {
  #     FHIR::Medication.new(
  #       id: 'medication-1'
  #     )
  #   }
  #   let(:medication_2) {
  #     FHIR::Medication.new(
  #       id: 'medication-2'
  #     )
  #   }
  #   let(:medication_3) {
  #     FHIR::Medication.new(
  #       id: 'medication-3'
  #     )
  #   }
  #   let(:bundle) {
  #     FHIR::Bundle.new(
  #       entry: [
  #         { resource: medication_request_1 },
  #         { resource: medication_request_2 }
  #       ]
  #     )
  #   }

  #   before do
  #     allow_any_instance_of(test_class)
  #       .to receive(:scratch).and_return(test_scratch)

  #     stub_request(:get, "#{url}/MedicationRequest?patient=#{patient_id}&intent=proposal")
  #       .to_return(status: 200, body: FHIR::Bundle.new.to_json)
  #     stub_request(:get, "#{url}/MedicationRequest?patient=#{patient_id}&intent=plan")
  #       .to_return(status: 200, body: FHIR::Bundle.new.to_json)
  #     stub_request(:get, "#{url}/MedicationRequest?patient=#{patient_id}&intent=original-order")
  #       .to_return(status: 200, body: FHIR::Bundle.new.to_json)
  #     stub_request(:get, "#{url}/MedicationRequest?patient=#{patient_id}&intent=reflex-order")
  #       .to_return(status: 200, body: FHIR::Bundle.new.to_json)
  #     stub_request(:get, "#{url}/MedicationRequest?patient=#{patient_id}&intent=filler-order")
  #       .to_return(status: 200, body: FHIR::Bundle.new.to_json)
  #     stub_request(:get, "#{url}/MedicationRequest?patient=#{patient_id}&intent=instance-order")
  #       .to_return(status: 200, body: FHIR::Bundle.new.to_json)
  #     stub_request(:get, "#{url}/MedicationRequest?patient=#{patient_id}&intent=option")
  #       .to_return(status: 200, body: FHIR::Bundle.new.to_json)
  #     stub_request(:get, "#{url}/MedicationRequest?patient=#{patient_id}&intent=order")
  #       .to_return(status: 200, body: bundle.to_json)
  #     stub_request(:post, "#{url}/MedicationRequest/_search")
  #       .with(body: {patient: patient_id, intent: 'order'})
  #       .to_return(status: 200, body: bundle.to_json)
  #     stub_request(:get, "#{url}/MedicationRequest?patient=Patient/#{patient_id}&intent=order")
  #       .to_return(status: 200, body: bundle.to_json)
  #     stub_request(:get, "#{url}/MedicationRequest?patient=#{patient_id}&intent=proposal,plan,order,original-order,reflex-order,filler-order,instance-order,option")
  #       .to_return(status: 200, body: bundle.to_json)
  #   end

  #   it 'passes when references and included Medications are exact match' do
  #     bundle.entry.concat([ {resource: medication_1 }, {resource: medication_2}])
  #     stub_request(:get, "#{url}/MedicationRequest?_include=MedicationRequest:medication&intent=#{intent}&patient=#{patient_id}")
  #       .to_return(status: 200, body: bundle.to_json)

  #     result = run(test_class, patient_ids: patient_id, url: url)
  #     puts "result is: #{result.to_json}"
  #     expect(result.result).to eq('pass')
  #   end

  #   it 'passes when there are more references than included Medications' do
  #     bundle.entry.concat([ {resource: medication_1 }])
  #     stub_request(:get, "#{url}/MedicationRequest?_include=MedicationRequest:medication&intent=#{intent}&patient=#{patient_id}")
  #       .to_return(status: 200, body: bundle.to_json)

  #     result = run(test_class, patient_ids: patient_id, url: url)
  #     expect(result.result).to eq('pass')
  #   end

  #   it 'fails when there are less references than included Medications' do
  #     bundle.entry.concat([ {resource: medication_1}, {resource: medication_2}, {resource: medication_3 }])
  #     stub_request(:get, "#{url}/MedicationRequest?_include=MedicationRequest:medication&intent=#{intent}&patient=#{patient_id}")
  #       .to_return(status: 200, body: bundle.to_json)

  #     result = run(test_class, patient_ids: patient_id, url: url)
  #     expect(result.result).to eq('fail')
  #     expect(result.result_message).to include(medication_3.id)
  #   end
  # end

  describe '#is_reference_match' do
    let(:test_class) { AUCoreTestKit::AUCoreV100_BALLOT::MedicationRequestPatientIntentSearchTest }
    let(:test) { test_class.new }
    let(:pattern_reference) { 'Medication/1' }

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
