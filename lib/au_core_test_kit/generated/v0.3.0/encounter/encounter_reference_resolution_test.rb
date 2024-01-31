require_relative '../../../reference_resolution_test'

module USCoreTestKit
  module USCoreV030
    class EncounterReferenceResolutionTest < Inferno::Test
      include USCoreTestKit::ReferenceResolutionTest

      title 'MustSupport references within Encounter resources are valid'
      description %(
        This test will attempt to read external references provided within elements
        marked as 'MustSupport', if any are available.

        It verifies that at least one external reference for each MustSupport Reference element
        can be accessed by the test client, and conforms to corresponding US Core profile.

        Elements which may provide external references include:

        * Encounter.location.location
        * Encounter.participant.individual
        * Encounter.reasonReference
        * Encounter.serviceProvider
        * Encounter.subject
      )

      id :us_core_v030_encounter_reference_resolution_test

      def resource_type
        'Encounter'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:encounter_resources] ||= {}
      end

      run do
        perform_reference_resolution_test(scratch_resources[:all])
      end
    end
  end
end
