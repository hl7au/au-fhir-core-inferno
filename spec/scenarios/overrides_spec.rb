# frozen_string_literal: true

require_relative '../../rakelib/scenarios/overrides'

RSpec.describe AUCoreTestKit::Scenarios::Overrides do
  fixtures = File.expand_path('../fixtures/scenarios/overrides', __dir__)
  full_file = File.join(fixtures, 'full/overrides.yml')

  it 'gives empty sections when the directory has no overrides.yml' do
    overrides = described_class.load(File.join(fixtures, 'absent'))

    expect([overrides.inputs, overrides.expected]).to eq([{}, {}])
    expect([overrides.fhir_pairs, overrides.validator_pairs, overrides.sources]).to eq([[], [], []])
    expect(overrides.expects_fail?).to be(false)
  end

  it 'reads every section of a full file' do
    overrides = described_class.load(File.join(fixtures, 'full'))
    yaml = YAML.safe_load_file(full_file)

    expect(overrides.inputs).to eq('patient_ids' => 'banks-mia-leanne')
    expect(overrides.sources).to eq(yaml.dig('server', 'fhir', 'sources'))
    expect(overrides.fhir_pairs).to eq(yaml.dig('server', 'fhir', 'pairs'))
    expect(overrides.validator_pairs).to eq(yaml.dig('server', 'validator', 'pairs'))
    expect(overrides.expected).to eq(yaml['expected'])
    expect(overrides.expects_fail?).to be(true)
  end

  it 'does not expect a fail from a file with only inputs' do
    expect(described_class.load(File.join(fixtures, 'inputs_only')).expects_fail?).to be(false)
  end

  describe '#known_gap?' do
    subject(:overrides) { described_class.load(File.join(fixtures, 'full')) }

    it 'matches a suggested request whatever the order of its query names and values' do
      suggested = { 'path' => '/Observation', 'query' => { 'category' => %w[vital-signs laboratory],
                                                           'patient' => 'wang-li' } }

      expect(overrides.known_gap?(suggested)).to be(true)
    end

    it 'misses a request with a different query value' do
      suggested = { 'path' => '/Observation', 'query' => { 'category' => %w[laboratory vital-signs],
                                                           'patient' => 'howe-deangelo' } }

      expect(overrides.known_gap?(suggested)).to be(false)
    end

    it 'misses the same query sent as a POST _search form body' do
      suggested = { 'method' => 'POST', 'path' => '/Observation/_search',
                    'body' => { 'category' => %w[laboratory vital-signs], 'patient' => 'wang-li' } }

      expect(overrides.known_gap?(suggested)).to be(false)
    end

    it 'misses a validator suggestion, which has no path' do
      expect(overrides.known_gap?({ 'profile' => 'http://example.org', 'resource' => {} })).to be(false)
    end
  end

  {
    'unknown_key' => %r{unknown_key/overrides\.yml: unknown top-level key "expectd"},
    'gap_without_reason' => %r{gap_without_reason/overrides\.yml: known_gaps\[0\] needs a non-empty reason},
    'bad_expected' => %r{bad_expected/overrides\.yml: expected "some-test" is "passed", not one of pass}
  }.each do |dir, message|
    it "rejects #{dir} naming the file and the entry" do
      expect { described_class.load(File.join(fixtures, dir)) }.to raise_error(described_class::Error, message)
    end
  end
end
