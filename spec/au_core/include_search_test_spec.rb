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
            run_include_test
          end
        end
      end
      let(:bundle) do
        FHIR::Bundle.new(entry: [{ resource: medication_request }, { resource: medication }])
      end
      let(:test_scratch) { {} }

      before do
        Inferno::Repositories::Tests.new.insert(medication_request_search_test)
        allow_any_instance_of(medication_request_search_test)
          .to receive(:scratch).and_return(test_scratch)
      end

      it 'passes performing an _include search' do
        stub_request(:get, "#{url}/MedicationRequest?_include=MedicationRequest:medication&patient=#{patient_id}")
          .to_return(status: 200, body: bundle.to_json)

        result = run(medication_request_search_test, patient_ids: patient_id, url:)

        expect(result.result).to eq('pass')
        expect(test_scratch[:medication_resources][:all]).to include(medication)
        expect(test_scratch[:medication_resources][:contained]).to include(medication)
        expect(test_scratch[:medication_resources][patient_id]).to include(medication)
      end
    end
  end
end
