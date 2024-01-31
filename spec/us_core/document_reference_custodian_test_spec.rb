require_relative '../../lib/us_core_test_kit/custom_groups/v4.0.0/document_reference_custodian_test'

RSpec.describe USCoreTestKit::USCoreV400::DocumentReferenceCustodianTest do
  let(:document_reference_custodian_test) { Inferno::Repositories::Tests.new.find('us_core_v400_document_reference_custodian_test') }
  let(:suite) { Inferno::Repositories::TestSuites.new.find('us_core_v400') }
  let(:session_data_repo) { Inferno::Repositories::SessionData.new }
  let(:test_session) { repo_create(:test_session, test_suite_id: suite.id) }
  let(:documentreference) { FHIR::DocumentReference.new(id: '1') }
  let(:provenance) { FHIR::Provenance.new(
      id: '1',
      target: [
        FHIR::Reference.new(reference: 'DocumentReference/1')
      ],
      agent: []
    )
  }

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


  it 'skips if no DocumentReference saved' do
    allow_any_instance_of(document_reference_custodian_test)
      .to receive(:scratch_resources).and_return({})

    result = run(document_reference_custodian_test)
    expect(result.result).to eq('skip')
  end

  it 'passes if DocumentReference.custodian presents' do
    documentreference.custodian = FHIR::Reference.new(
      reference: 'Oganization/1'
    )

    allow_any_instance_of(document_reference_custodian_test)
      .to receive(:scratch_resources).and_return(
        {
          all: [ documentreference ]
        }
      )

    result = run(document_reference_custodian_test)
    expect(result.result).to eq('pass')
  end

  it 'fails if no DocumentReference.custodian is not present' do
    allow_any_instance_of(document_reference_custodian_test)
      .to receive(:scratch_resources).and_return(
        {
          all: [ documentreference ]
        }
      )

    result = run(document_reference_custodian_test)
    expect(result.result).to eq('fail')
  end

  it 'passes if Provenance.agent.who presents' do
    allow_any_instance_of(document_reference_custodian_test)
      .to receive(:scratch_resources).and_return(
        {
          all: [ documentreference ]
        }
      )

    provenance.agent << FHIR::Provenance::Agent.new(who: FHIR::Reference.new(reference: 'Organization/1'))

    allow_any_instance_of(document_reference_custodian_test)
      .to receive(:scratch_provenance_resources).and_return(
        {
          all: [ provenance ]
        }
      )

    result = run(document_reference_custodian_test)
    expect(result.result).to eq('pass')
  end

  it 'fails if Provenance.target does not include DocumentReference/1' do
    allow_any_instance_of(document_reference_custodian_test)
      .to receive(:scratch_resources).and_return(
        {
          all: [ documentreference ]
        }
      )

    provenance.target = [
      FHIR::Reference.new(reference: 'DocumentReference/100')
    ]
    provenance.agent << FHIR::Provenance::Agent.new(who: FHIR::Reference.new(reference: 'Organization/1'))

    allow_any_instance_of(document_reference_custodian_test)
      .to receive(:scratch_provenance_resources).and_return(
        {
          all: [ provenance ]
        }
      )

    result = run(document_reference_custodian_test)
    expect(result.result).to eq('fail')
  end

  it 'passes if Provenance.agent.onBehalfOf presents' do
    allow_any_instance_of(document_reference_custodian_test)
      .to receive(:scratch_resources).and_return(
        {
          all: [ documentreference ]
        }
      )

    provenance.agent << FHIR::Provenance::Agent.new(onBehalfOf: FHIR::Reference.new(reference: 'Organization/1'))

    allow_any_instance_of(document_reference_custodian_test)
      .to receive(:scratch_provenance_resources).and_return(
        {
          all: [ provenance ]
        }
      )

    result = run(document_reference_custodian_test)
    expect(result.result).to eq('pass')
  end
end