# frozen_string_literal: true

require Inferno::SpecSupport::RUNNABLE_HELPER_PATH
require_relative '../support/scenario'

RSpec.describe 'Scenarios against fhir_stub_server' do
  Scenario.all.each do |scenario|
    context scenario.name do
      include_context 'when testing a runnable'

      let(:suite_id) { scenario.suite_id }

      def run_in_process(scenario)
        stub = scenario.stub
        FHIRStubServer::WebMockAdapter.install(stub, fhir_base_url: Scenario::FHIR_BASE_URL,
                                                     validator_base_url: ENV.fetch('FHIR_RESOURCE_VALIDATOR_URL'))
        inputs = scenario.inputs_with(Scenario::FHIR_BASE_URL).transform_keys(&:to_sym)
        scenario.groups_in(suite).each { |group| run(group, inputs) }
        Scenario::Run.new(stub, results_by_short_id)
      end

      def results_by_short_id
        results = Inferno::Repositories::Results.new.current_results_for_test_session(test_session.id)
        Scenario.by_short_id(results.map { |result| [result.test_id, result.result] })
      end

      def expect_expected_results(run, scenario)
        aggregate_failures do
          expect(run.unmatched_report).to be_empty, run.unmatched_report
          expect(run.context_mismatch_report).to be_empty, run.context_mismatch_report
          expect(run.results).to eq(scenario.expected)
        end
      end

      it 'gets the expected results in process, with every request answered' do
        expect_expected_results(run_in_process(scenario), scenario)
      end

      it 'gets the expected results through inferno execute, with every request answered' do
        expect_expected_results(scenario.execute_run(suite), scenario)
      end

      it 'gets the same results in both modes' do
        in_process = run_in_process(scenario).results
        executed = scenario.execute_run(suite).results
        differing = (in_process.keys | executed.keys).reject { |id| in_process[id] == executed[id] }

        expect(differing).to be_empty, differing.map { |id|
          "#{id}: #{in_process[id].inspect} in process, #{executed[id].inspect} through inferno execute"
        }.join("\n")
      end
    end
  end
end
