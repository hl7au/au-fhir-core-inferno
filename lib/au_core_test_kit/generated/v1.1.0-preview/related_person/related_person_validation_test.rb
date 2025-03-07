# frozen_string_literal: true

require_relative '../../../validation_test'

module AUCoreTestKit
  module AUCoreV110_PREVIEW
    class RelatedPersonValidationTest < Inferno::Test
      include AUCoreTestKit::ValidationTest

      id :au_core_v110_preview_related_person_validation_test
      title 'RelatedPerson resources returned during previous tests conform to the AU Core RelatedPerson'
      description %(
This test verifies resources returned from the first search conform to
the [AU Core RelatedPerson](http://hl7.org.au/fhir/core/StructureDefinition/au-core-relatedperson).
If at least one resource from the first search is invalid, the test will fail.

It verifies the presence of mandatory elements and that elements with
required bindings contain appropriate values. CodeableConcept element
bindings will fail if none of their codings have a code/system belonging
to the bound ValueSet. Quantity, Coding, and code element bindings will
fail if their code/system are not found in the valueset.

      )
      output :dar_code_found, :dar_extension_found

      def resource_type
        'RelatedPerson'
      end

      def scratch_resources
        scratch[:related_person_resources] ||= {}
      end

      run do
        perform_validation_test(scratch_resources[:all] || [],
                                'http://hl7.org.au/fhir/core/StructureDefinition/au-core-relatedperson',
                                '1.1.0-preview',
                                skip_if_empty: true)
      end
    end
  end
end
