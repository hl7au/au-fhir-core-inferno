require_relative '../../../validation_test'

module USCoreTestKit
  module USCoreV030
    class AuCoreConditionValidationTest < Inferno::Test
      include USCoreTestKit::ValidationTest

      id :us_core_v030_au_core_condition_validation_test
      title 'Condition resources returned during previous tests conform to the AU Core Condition'
      description %(
This test verifies resources returned from the first search conform to
the [AU Core Condition](http://hl7.org.au/fhir/core/StructureDefinition/au-core-condition).
Systems must demonstrate at least one valid example in order to pass this test.

It verifies the presence of mandatory elements and that elements with
required bindings contain appropriate values. CodeableConcept element
bindings will fail if none of their codings have a code/system belonging
to the bound ValueSet. Quantity, Coding, and code element bindings will
fail if their code/system are not found in the valueset.

      )
      output :dar_code_found, :dar_extension_found

      def resource_type
        'Condition'
      end

      def scratch_resources
        scratch[:au_core_condition_resources] ||= {}
      end

      run do
        perform_validation_test(scratch_resources[:all] || [],
                                'http://hl7.org.au/fhir/core/StructureDefinition/au-core-condition',
                                '0.3.0',
                                skip_if_empty: true)
      end
    end
  end
end
