module USCoreTestKit
  class ClinicalNoteAttachmentTest < Inferno::Test
    id :us_core_clinical_note_attachments
    title 'DiagnosticReport and DocumentReference reference the same attachment'
    description %(
      All presentedForms urls referenced in DiagnosticReports shall have
      corresponding content attachment urls referenced in DocumentReference.

      There is no single best practice for representing a scanned, or
      narrative-only report due to the overlapping scope of the underlying
      resources and variability in system implementation. Reports may be
      represented by either a DocumentReference or a DiagnosticReport. To
      require Clients query both DocumentReference and DiagnosticReport to get
      all the information for a patient is potentially dangerous if a client
      doesn’t understand or follow this requirement.

      To simplify the requirement, US Core IG requires servers implement the
      duplicate reference to allow a client to find a Pathology report, or
      other Diagnostic Reports, in either Resource.
    )

    run do
      skip_if scratch[:document_reference_attachments].blank?,
              "No DocumentReference attachments found"
      skip_if scratch[:diagnostic_report_attachments].blank?,
              "No DiagnosticReport attachments found"

      unmatched_attachment_messages =
        scratch[:diagnostic_report_attachments].flat_map do |patient_id, report_attachments|
          unmatched_urls = report_attachments.keys

          if scratch[:document_reference_attachments].key? patient_id
            unmatched_urls -= scratch[:document_reference_attachments][patient_id].keys
          end

          unmatched_urls.map do |url|
            "#{url} in DiagnosticReport/#{report_attachments[url]} for Patient #{patient_id}"
          end
        end

      assert unmatched_attachment_messages.empty?,
            "Attachments #{unmatched_attachment_messages.join(', ')} are not referenced in any DocumentReference"
    end
  end
end
