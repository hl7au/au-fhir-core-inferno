# frozen_string_literal: true

require 'inferno_suite_generator/test_modules/validation_test'

module AUCoreTestKit
  module AUCoreV200
    class MedicationRequestMedicationInclusionValidationTest < Inferno::Test
      include InfernoSuiteGenerator::ValidationTest

      id :au_core_v200_medication_request_medication_validation_test_1
      title 'Medication resources returned during previous tests conform to the AU Core MedicationRequest'
      description %(

This test verifies resources returned from previous tests conform to
the [AU Core Medication](http://hl7.org.au/fhir/core/StructureDefinition/au-core-medication).

It verifies the presence of mandatory elements and that elements with
required bindings contain appropriate values. CodeableConcept element
bindings will fail if none of their codings have a code/system belonging
to the bound ValueSet. Quantity, Coding, and code element bindings will
fail if their code/system are not found in the valueset.


      )
      output :dar_code_found, :dar_extension_found

      def resource_type
        'Medication'
      end

      def scratch_resources
        scratch[:medication_resources] ||= {}
      end

      def filter_set
        []
      end

      run do
        perform_validation_test(scratch_resources[:all] || [],
                                'http://hl7.org.au/fhir/core/StructureDefinition/au-core-medication',
                                '2.0.0',
                                skip_if_empty: false)
      end
    end
  end
end
