require_relative '../../lib/us_core_test_kit/custom_groups/v3.1.1/profile_support_test'

RSpec.describe USCoreTestKit::USCoreV311::ProfileSupportTest do
  def run(runnable, inputs = {})
    test_run_params = { test_session_id: test_session.id }.merge(runnable.reference_hash)
    test_run = Inferno::Repositories::TestRuns.new.create(test_run_params)
    inputs.each do |name, value|
      session_data_repo.save(
        test_session_id: test_session.id,
        name: name,
        value: value,
        type: runnable.config.input_type(name) || 'text'
      )
    end
    Inferno::TestRunner.new(test_session: test_session, test_run: test_run).run(runnable)
  end

  let(:session_data_repo) { Inferno::Repositories::SessionData.new }
  let(:test_session) { repo_create(:test_session, test_suite_id: suite.id) }
  let(:suite) { Inferno::Repositories::TestSuites.new.find('us_core_v311') }
  let(:test) { described_class }
  let(:url) { 'http://example.com/fhir' }

  context 'with no required resources' do
    before do
      allow_any_instance_of(test).to receive(:config).and_return(
                                       OpenStruct.new(
                                         options: {
                                           us_core_resources: ['Patient', 'Condition', 'Observation']
                                         }
                                       )
                                     )
    end

    it 'fails if Patient is not supported' do
      response_body =
        FHIR::CapabilityStatement.new(
          rest: [
            {
              resource: [
                {
                  type: 'Condition'
                }
              ]
            }
          ]
        ).to_json
      repo_create(:request, response_body:, name: 'capability_statement', test_session_id: test_session.id)

      result = run(test, url:)

      expect(result.result).to eq('fail')
      expect(result.result_message).to eq('US Core Patient profile not supported')
    end

    it 'fails if only the Patient resource is supported' do
      response_body =
        FHIR::CapabilityStatement.new(
          rest: [
            {
              resource: [
                {
                  type: 'Patient'
                }
              ]
            }
          ]
        ).to_json
      repo_create(:request, response_body:, name: 'capability_statement', test_session_id: test_session.id)

      result = run(test, url:)

      expect(result.result).to eq('fail')
      expect(result.result_message).to eq('No US Core resources other than Patient are supported')
    end

    it 'passes if Patient and one other resource are supported' do
      response_body =
        FHIR::CapabilityStatement.new(
          rest: [
            {
              resource: [
                {
                  type: 'Patient'
                },
                {
                  type: 'Observation'
                }
              ]
            }
          ]
        ).to_json
      repo_create(:request, response_body:, name: 'capability_statement', test_session_id: test_session.id)

      result = run(test, url:)

      expect(result.result).to eq('pass')
    end
  end

  context 'with required resources' do
    before do
      allow_any_instance_of(test).to receive(:config).and_return(
                                       OpenStruct.new(
                                         options: {
                                           us_core_resources: ['Patient', 'Condition', 'Observation'],
                                           required_resources: ['Patient', 'Condition', 'Observation']
                                         }
                                       )
                                     )
    end

    it 'fails if not all required resources are supported' do
      response_body =
        FHIR::CapabilityStatement.new(
          rest: [
            {
              resource: [
                {
                  type: 'Patient'
                },
                {
                  type: 'Observation'
                }
              ]
            }
          ]
        ).to_json
      repo_create(:request, response_body:, name: 'capability_statement', test_session_id: test_session.id)

      result = run(test, url:)

      expect(result.result).to eq('fail')
      expect(result.result_message).to include('Condition')
    end

    it 'passes if not required resources are supported' do
      response_body =
        FHIR::CapabilityStatement.new(
          rest: [
            {
              resource: [
                {
                  type: 'Patient'
                },
                {
                  type: 'Observation'
                },
                {
                  type: 'Condition'
                }
              ]
            }
          ]
        ).to_json
      repo_create(:request, response_body:, name: 'capability_statement', test_session_id: test_session.id)

      result = run(test, url:)

      expect(result.result).to eq('pass')
    end
  end
end
