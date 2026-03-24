# frozen_string_literal: true

require 'inferno_suite_generator'

module InfernoSuiteGenerator
  class Generator
    class MedicationInclusionTestGenerator < InfernoSuiteGenerator::Generator::ValidationTestGenerator
      class << self
        def generate(ig_metadata, base_output_dir, absolute_template_path)
          medication_request_group = ig_metadata.groups.find { |group| group.resource == 'MedicationRequest' }
          new(medication_request_group, ig_metadata, base_output_dir, absolute_template_path).generate
        end
      end

      attr_accessor :group_metadata, :search_metadata, :base_output_dir, :special_identifier, :absolute_template_path, :ig_metadata

      def initialize(group_metadata, ig_metadata, base_output_dir, absolute_template_path)
        super(group_metadata, ig_metadata, nil, base_output_dir: base_output_dir)
        self.absolute_template_path = absolute_template_path
      end

      def class_name
        "#{Naming.upper_camel_case_for_profile(group_metadata)}MedicationInclusionValidationTest"
      end

      def title
        'Medication resources returned during previous tests conform to the AU Core Medication'
      end

      def description
        %(
This test verifies resources returned from previous tests conform to
the [AU Core Medication](http://hl7.org.au/fhir/core/StructureDefinition/au-core-medication).

It verifies the presence of mandatory elements and that elements with
required bindings contain appropriate values. CodeableConcept element
bindings will fail if none of their codings have a code/system belonging
to the bound ValueSet. Quantity, Coding, and code element bindings will
fail if their code/system are not found in the valueset.

      )
      end

      def resource_type
        'Medication'
      end

      def profile_identifier
        'medication'
      end

      def profile_url
        'http://hl7.org.au/fhir/core/StructureDefinition/au-core-medication'
      end

      def test_id
        "au_core_#{group_metadata.reformatted_version}_medication_request_medication_validation_test_1"
      end
    end
  end
end
