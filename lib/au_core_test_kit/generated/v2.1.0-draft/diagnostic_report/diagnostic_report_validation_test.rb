# frozen_string_literal: true

require 'inferno_suite_generator/test_modules/validation_test'

module AUCoreTestKit
  module AUCoreV210_DRAFT
    class DiagnosticReportValidationTest < Inferno::Test
      include InfernoSuiteGenerator::ValidationTest

      id :au_core_v210_draft_diagnostic_report_validation_test
      title 'DiagnosticReport resources returned during previous tests conform to the AU Core DiagnosticReport'
      description %(
This test verifies resources returned from the first search conform to
the [AU Core DiagnosticReport](http://hl7.org.au/fhir/core/StructureDefinition/au-core-diagnosticreport).
If at least one resource from the first search is invalid, the test will fail.

It verifies the presence of mandatory elements and that elements with
required bindings contain appropriate values. CodeableConcept element
bindings will fail if none of their codings have a code/system belonging
to the bound ValueSet. Quantity, Coding, and code element bindings will
fail if their code/system are not found in the valueset.

      )
      output :dar_code_found, :dar_extension_found

      def resource_type
        'DiagnosticReport'
      end

      def scratch_resources
        scratch[:diagnostic_report_resources] ||= {}
      end

      def filter_set
        []
      end

      run do
        perform_validation_test(scratch_resources[:all] || [],
                                'http://hl7.org.au/fhir/core/StructureDefinition/au-core-diagnosticreport',
                                '2.1.0-draft',
                                skip_if_empty: true)
      end
    end
  end
end
