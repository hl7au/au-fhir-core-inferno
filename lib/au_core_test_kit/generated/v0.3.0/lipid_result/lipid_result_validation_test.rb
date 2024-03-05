require_relative '../../../validation_test'

module AUCoreTestKit
  module AUCoreV030
    class LipidResultValidationTest < Inferno::Test
      include AUCoreTestKit::ValidationTest

      id :au_core_v030_lipid_result_validation_test
      title 'Observation resources returned during previous tests conform to the AU Core Lipid Result'
      description %(
This test verifies resources returned from the first search conform to
the [AU Core Lipid Result](http://hl7.org.au/fhir/core/StructureDefinition/au-core-lipid-result).
Systems must demonstrate at least one valid example in order to pass this test.

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
        scratch[:lipid_result_resources] ||= {}
      end

      run do
        perform_validation_test(scratch_resources[:all] || [],
                                'http://hl7.org.au/fhir/core/StructureDefinition/au-core-lipid-result',
                                '0.3.0',
                                skip_if_empty: true)
      end
    end
  end
end
