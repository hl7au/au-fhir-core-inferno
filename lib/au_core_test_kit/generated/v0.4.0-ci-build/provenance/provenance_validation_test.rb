# frozen_string_literal: true

require_relative '../../../validation_test'

module AUCoreTestKit
  module AUCoreV040_CI_BUILD
    class ProvenanceValidationTest < Inferno::Test
      include AUCoreTestKit::ValidationTest

      id :au_core_v040_ci_build_provenance_validation_test
      title 'Provenance resources returned during previous tests conform to the AU Core Provenance'
      description %(
This test verifies resources returned from the first search conform to
the [AU Core Provenance](http://hl7.org.au/fhir/core/StructureDefinition/au-core-provenance).
Systems must demonstrate at least one valid example in order to pass this test.

It verifies the presence of mandatory elements and that elements with
required bindings contain appropriate values. CodeableConcept element
bindings will fail if none of their codings have a code/system belonging
to the bound ValueSet. Quantity, Coding, and code element bindings will
fail if their code/system are not found in the valueset.

      )
      output :dar_code_found, :dar_extension_found

      def resource_type
        'Provenance'
      end

      def scratch_resources
        scratch[:provenance_resources] ||= {}
      end

      run do
        perform_validation_test(scratch_resources[:all] || [],
                                'http://hl7.org.au/fhir/core/StructureDefinition/au-core-provenance',
                                '0.4.0-ci-build',
                                skip_if_empty: true)
      end
    end
  end
end