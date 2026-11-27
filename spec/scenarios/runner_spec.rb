# frozen_string_literal: true

require_relative '../../rakelib/scenarios/runner'

RSpec.describe AUCoreTestKit::Scenarios::Runner do
  suite_id = 'au_core_v300_ballot1'
  package = AUCoreTestKit::Scenarios::Suites.find(suite_id).package_path
  repo_root = File.expand_path('../..', __dir__)
  # No validator block: the Runner adds an empty one, so validator calls stay on the Stub.
  server = { 'fhir' => { 'sources' => [{ 'package' => package }] } }

  it 'runs one group in a child inferno execute against the Stub and returns its results' do
    fhir_api = Inferno::Repositories::TestSuites.new.find(suite_id).groups.first
    group = fhir_api.groups.find { |g| g.id.end_with?('capability_statement') }

    run = described_class.new.run(suite_id:, inputs: {}, server:, dir: repo_root, groups: [group.short_id])

    expect(run.results.keys).to match_array(group.tests.map(&:id))
    expect(run.stub.served).to include(a_hash_including(request: a_hash_including(method: 'GET', path: '/metadata'),
                                                        answered_by: :demo_data))
    validator_misses = run.stub.unmatched.select { |miss| miss[:request][:role] == :validator }
    expect(validator_misses).not_to be_empty
    expect(validator_misses.map { |miss| miss[:suggested_request].keys }).to all(eq(%w[profile resource]))
  end

  it 'raises with the child output for an unknown suite' do
    expect { described_class.new.run(suite_id: 'no_such_suite', inputs: {}, server:, dir: repo_root) }
      .to raise_error(AUCoreTestKit::Scenarios::Runner::Error, /no_such_suite/)
  end
end
