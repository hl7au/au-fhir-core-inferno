# frozen_string_literal: true

require_relative '../../../validation_test'

module AUCoreTestKit
  module AUCoreV100_PREVIEW
    class BodyweightValidationTest < Inferno::Test
      include AUCoreTestKit::ValidationTest

      id :au_core_v100_preview_bodyweight_validation_test
      title 'Observation resources returned during previous tests conform to the AU Core Body Weight'
      description %(
This test verifies resources returned from the first search conform to
the [AU Core Body Weight](http://hl7.org.au/fhir/core/StructureDefinition/au-core-bodyweight).
If at least one resource from the first search is invalid, the test will fail.

It verifies the presence of mandatory elements and that elements with
required bindings contain appropriate values. CodeableConcept element
bindings will fail if none of their codings have a code/system belonging
to the bound ValueSet. Quantity, Coding, and code element bindings will
fail if their code/system are not found in the valueset.

      )
      output :dar_code_found, :dar_extension_found

      def resource_type
        'Observation'
      end

      def scratch_resources
        scratch[:bodyweight_resources] ||= {}
      end

      run do
        perform_validation_test(scratch_resources[:all] || [],
                                'http://hl7.org.au/fhir/core/StructureDefinition/au-core-bodyweight',
                                '1.0.0-preview',
                                skip_if_empty: true)
      end
    end
  end
end