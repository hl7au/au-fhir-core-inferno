# frozen_string_literal: true

require 'inferno_suite_generator/validation_test'

module AUCoreTestKit
  module AUCoreV100
    class PatientValidationTest < Inferno::Test
      include InfernoSuiteGenerator::ValidationTest

      id :au_core_v100_patient_validation_test
      title 'Patient resources returned during previous tests conform to the AU Core Patient'
      description %(
This test verifies resources returned from the first search conform to
the [AU Core Patient](http://hl7.org.au/fhir/core/StructureDefinition/au-core-patient).
If at least one resource from the first search is invalid, the test will fail.

It verifies the presence of mandatory elements and that elements with
required bindings contain appropriate values. CodeableConcept element
bindings will fail if none of their codings have a code/system belonging
to the bound ValueSet. Quantity, Coding, and code element bindings will
fail if their code/system are not found in the valueset.

      )
      output :dar_code_found, :dar_extension_found

      def resource_type
        'Patient'
      end

      def scratch_resources
        scratch[:patient_resources] ||= {}
      end

      run do
        perform_validation_test(scratch_resources[:all] || [],
                                'http://hl7.org.au/fhir/core/StructureDefinition/au-core-patient',
                                '1.0.0',
                                skip_if_empty: true)
      end
    end
  end
end
