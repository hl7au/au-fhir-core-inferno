# frozen_string_literal: true

require_relative '../../rakelib/scenarios/inputs'

RSpec.describe AUCoreTestKit::Scenarios::Inputs do
  suites = AUCoreTestKit::Scenarios::Suites

  suites.all.each do |suite|
    it "gives #{suite.suite_id} the shared patient_ids and only inputs it declares" do
      declared = Inferno::Repositories::TestSuites.new.find(suite.suite_id).available_inputs.keys.map(&:to_s)

      inputs = described_class.for(suite, {})

      expect(inputs['patient_ids']).to eq('wang-li, howe-deangelo')
      expect(declared).to include(*inputs.keys)
    end
  end

  it 'leaves endpoint_ids and healthcare_service_ids out of au_core_v100, which declares neither' do
    expect(described_class.for(suites.find('au_core_v100'), {})).not_to include('endpoint_ids', 'healthcare_service_ids')
  end

  it 'lets an override replace one shared input and leaves the others' do
    suite = suites.find('au_core_v300_ballot1')

    inputs = described_class.for(suite, { 'patient_ids' => 'banks-mia-leanne' })

    expect(inputs).to eq(described_class.for(suite, {}).merge('patient_ids' => 'banks-mia-leanne'))
  end

  it 'raises naming the suite, input, id and package when an id is not an IG example' do
    expect { described_class.for(suites.find('au_core_v300_ballot1'), { 'patient_ids' => 'wang-li, nobody' }) }
      .to raise_error(described_class::Error, 'au_core_v300_ballot1: patient_ids id "nobody" is not a Patient ' \
                                              'example in lib/au_core_test_kit/igs/3.0.0-ballot1.tgz')
  end

  it 'passes an override input that is not an id list through unchecked' do
    inputs = described_class.for(suites.find('au_core_v100'), { 'smart_auth_info' => 'nobody' })

    expect(inputs['smart_auth_info']).to eq('nobody')
  end
end
