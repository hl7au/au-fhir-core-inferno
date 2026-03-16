# frozen_string_literal: true

require 'inferno_suite_generator/test_modules/reference_resolution_test'

module AUCoreTestKit
  module AUCoreV200
    class LocationReferenceResolutionTest < Inferno::Test
      include InfernoSuiteGenerator::ReferenceResolutionTest

      title 'MustSupport references within Location resources are valid'
      description %(
        This test will attempt to read external references provided within elements
        marked as 'MustSupport', if any are available.

        It verifies that at least one external reference for each MustSupport Reference element
        can be accessed by the test client, and conforms to corresponding AU Core profile.

        Elements which may provide external references include:

        * Location.managingOrganization
      )

      id :au_core_v200_location_reference_resolution_test

      def resource_type
        'Location'
      end

      def self.metadata
        @metadata ||= InfernoSuiteGenerator::Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:location_resources] ||= {}
      end

      run do
        perform_reference_resolution_test(scratch_resources[:all], { 'http://hl7.org.au/fhir/StructureDefinition/au-specimen' => 'http://hl7.org.au/fhir/StructureDefinition/au-specimen|5.1.0-preview' })
      end
    end
  end
end
