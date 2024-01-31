require_relative '../search_test'

module AUCoreTestKit
  class ClinicalNoteTypeTest < Inferno::Test
    include SearchTest

    id :au_core_clinical_note_types
    title 'Server demonstrates support for the required DocumentReference types and DiagnosticReport categories.'

    input :patient_ids,
          title: 'Patient IDs',
          description: 'Comma separated list of patient IDs that in sum contain all MUST SUPPORT elements'

    REQUIRED_CATEGORIES = ['LP29708-2', 'LP7839-6', 'LP29684-5'].freeze

    def document_reference_types_found(patient_id)
      search_params = { patient: patient_id }
      status_values = ['current,superseded,entered-in-error']

      search_and_check_response(search_params, 'DocumentReference')

      if response[:status] == 400
        perform_search_with_status(
          params,
          patient_id,
          status_search_values: status_values,
          resource_type: 'DocumentReference'
        )
      end

      resources = fetch_all_bundled_resources(resource_type: 'DocumentReference')
                    .select { |resource| resource.resourceType == 'DocumentReference' }

      scratch[:document_reference_attachments] ||= {}
      scratch[:document_reference_attachments][patient_id] ||= {}
      attachments = scratch[:document_reference_attachments][patient_id]

      codes_found =
        resources.flat_map do |resource|
          resource.content
            &.select { |content| content.attachment&.url.present? && !attachments.key?(content.attachment&.url) }
            &.each { |content| attachments[content.attachment.url] = resource.id }

          resource.type&.coding&.map { |coding| coding.code }
        end

      codes_found.compact.uniq
    end

    def diagnostic_report_categories_found(patient_id)
      search_params = { patient: patient_id }
      status_values = ['registered,partial,preliminary,final,amended,corrected,appended,cancelled,entered-in-error,unknown']
      search_and_check_response(search_params, 'DiagnosticReport')

      if response[:status] == 400
        perform_search_with_status(
          params,
          patient_id,
          status_search_values: status_values,
          resource_type: 'DiagnosticReport'
        )
      end

      resources = fetch_all_bundled_resources(resource_type: 'DiagnosticReport')
                    .select { |resource| resource.resourceType == 'DiagnosticReport' }

      scratch[:diagnostic_report_attachments] ||= {}
      scratch[:diagnostic_report_attachments][patient_id] ||= {}
      attachments = scratch[:diagnostic_report_attachments][patient_id]

      codes_found =
        resources.flat_map do |resource|
          codes = resource.category&.flat_map do |category|
            category.coding&.map { |coding| coding.code if REQUIRED_CATEGORIES.include?(coding.code) }
          end.compact

          if codes.present?
            resource.presentedForm
              &.select { |attachment| attachment&.url.present? && !attachments.key?(attachment&.url) }
              &.each { |attachment| attachments[attachment.url] = resource.id }
          end

          codes
        end

      codes_found.compact.uniq
    end

    run do
      missing_types = config.options[:required_types].dup
      missing_categories = REQUIRED_CATEGORIES.dup

      patient_id_list.each do |patient_id|
        missing_types -= document_reference_types_found(patient_id)
        missing_categories -= diagnostic_report_categories_found(patient_id)
      end

      pass if missing_types.empty? && missing_categories.empty?

      message = 'Could not find these '

      if missing_types.present?
        message += "DocumentReference types: #{missing_types.join(', ')}"
        message += ' and ' if missing_categories.present?
      end

      if missing_categories.present?
        message += "DiagnosticReport categories #{missing_categories.join(', ')}."
      end

      skip message
    end
  end
end