require_relative '../../lib/us_core_test_kit/custom_groups/clinical_note_type_test'

RSpec.describe USCoreTestKit::ClinicalNoteTypeTest do
  let(:url) { 'http://example.com/fhir' }
  let(:patient_id) { '85' }
  let(:test_scratch) { {} }
  let(:test_class) do
    Class.new(USCoreTestKit::ClinicalNoteTypeTest) do
      fhir_client { url 'http://example.com/fhir' }
    end
  end
  let(:runnable) { test_class.new }
  let(:diagnostic_report_cardiology) {
    FHIR::DiagnosticReport.new(
      id: 'cardiology',
      category: { coding: [{ code: 'LP29708-2' }] },
      presentedForm: [{ url: "#{url}/Binary/cardiology" }]
    )
  }
  let(:diagnostic_report_pathology) {
    FHIR::DiagnosticReport.new(
      id: 'pathology',
      category: { coding: [{ code: 'LP7839-6' }] },
      presentedForm: [{ url: "#{url}/Binary/pathology" }]
    )
  }
  let(:diagnostic_report_radiology) {
    FHIR::DiagnosticReport.new(
      id: 'radiology',
      category: { coding: [{ code: 'LP29684-5' }] },
      presentedForm: [{ url: "#{url}/Binary/radiology" }]
    )
  }
  let(:diagnostic_report_lab) {
    FHIR::DiagnosticReport.new(
      id: 'lab',
      category: { coding: [{ code: 'LAB' }] },
      presentedForm: [{ url: "#{url}/Binary/lab" }]
    )
  }
  let(:diagnostic_report_bundle) {
    FHIR::Bundle.new(
      entry: [
        { resource: diagnostic_report_cardiology},
        { resource: diagnostic_report_pathology},
        { resource: diagnostic_report_radiology},
        { resource: diagnostic_report_lab}
      ]
    )
  }

  describe '#diagnostic_report_categories_found' do
    before do
      stub_request(:get, "#{url}/DiagnosticReport?patient=#{patient_id}")
        .to_return(status: 200, body: diagnostic_report_bundle.to_json)

      allow_any_instance_of(test_class)
        .to receive(:scratch).and_return(test_scratch)
    end

    it 'returns requried category codes' do
      result = runnable.diagnostic_report_categories_found(patient_id)
      attachments = test_scratch[:diagnostic_report_attachments][patient_id].keys

      expect(result.length).to be(3)
      expect(result).not_to include('LAB')
      expect(attachments.length).to be(3)
      expect(attachments).not_to include("#{url}/Binary/lab")
    end
  end
end