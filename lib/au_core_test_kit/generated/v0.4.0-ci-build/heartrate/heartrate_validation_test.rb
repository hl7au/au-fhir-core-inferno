# frozen_string_literal: true

require_relative '../../../validation_test'

module AUCoreTestKit
  module AUCoreV040_CI_BUILD
    class HeartrateValidationTest < Inferno::Test
      include AUCoreTestKit::ValidationTest

      id :au_core_v040_ci_build_heartrate_validation_test
      title 'Observation resources returned during previous tests conform to the AU Core Heart Rate'
      description %(
This test verifies resources returned from the first search conform to
the [AU Core Heart Rate](http://hl7.org.au/fhir/core/StructureDefinition/au-core-heartrate).
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
        scratch[:heartrate_resources] ||= {}
      end

      run do
        perform_validation_test(scratch_resources[:all] || [],
                                'http://hl7.org.au/fhir/core/StructureDefinition/au-core-heartrate',
                                '0.4.0-ci-build',
                                skip_if_empty: true)
      end
    end
  end
end
