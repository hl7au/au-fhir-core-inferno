require_relative '../../lib/us_core_test_kit/custom_groups/clinical_note_attachment_test'

RSpec.describe USCoreTestKit::ClinicalNoteAttachmentTest do
  let(:clinical_note_attachment_test) { Inferno::Repositories::Tests.new.find('us_core_clinical_note_attachments') }
  let(:suite) { Inferno::Repositories::TestSuites.new.find('us_core_v311') }
  let(:session_data_repo) { Inferno::Repositories::SessionData.new }
  let(:test_session) { repo_create(:test_session, test_suite_id: suite.id) }
  let(:url) { 'http://example.com/fhir' }
  let(:patient_id) { '85' }
  let(:diagnostic_report_id) { '200' }
  let(:test_scratch) {
    {
      document_reference_attachments: {
        patient_id => { "#{url}/Binary/1" => "100" }
      },
      diagnostic_report_attachments: {
        patient_id => { "#{url}/Binary/2" => diagnostic_report_id }
      }
    }
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


  it 'catches missing attachment' do
    allow_any_instance_of(clinical_note_attachment_test)
      .to receive(:scratch).and_return(test_scratch)

    result = run(clinical_note_attachment_test)
    expect(result.result).to eq('fail')
    expect(result.result_message).to include("#{url}/Binary/2 in DiagnosticReport/#{diagnostic_report_id} for Patient #{patient_id}")
  end
end