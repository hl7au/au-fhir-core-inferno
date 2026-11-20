# frozen_string_literal: true

require Inferno::SpecSupport::RUNNABLE_HELPER_PATH
require_relative '../support/scenario'

RSpec.describe 'Scenarios against fhir_stub_server' do
  Scenario.all.each do |scenario|
    context "#{scenario.name}, in process" do
      include_context 'when testing a runnable'

      let(:suite_id) { scenario.suite_id }
      let(:stub) { scenario.stub }

      def results_by_short_id
        results = Inferno::Repositories::Results.new.current_results_for_test_session(test_session.id)
        results.select(&:test_id).to_h { |result| [result.test_id.split('-').last, result.result] }
      end

      def context_mismatch_report
        stub.context_mismatches.map do |mismatch|
          "Validator #{mismatch[:key]}: expected #{mismatch[:expected].inspect}, got #{mismatch[:actual].inspect}"
        end.join("\n")
      end

      it 'gets the expected results with every request answered' do
        FHIRStubServer::WebMockAdapter.install(stub, fhir_base_url: Scenario::FHIR_BASE_URL,
                                                     validator_base_url: ENV.fetch('FHIR_RESOURCE_VALIDATOR_URL'))
        scenario.group_ids.each { |group_id| run(find_test(suite, group_id), scenario.inputs) }

        aggregate_failures do
          expect(stub.unmatched).to be_empty, stub.unmatched_report
          expect(stub.context_mismatches).to be_empty, context_mismatch_report
          expect(results_by_short_id).to eq(scenario.expected)
        end
      end
    end
  end
end
