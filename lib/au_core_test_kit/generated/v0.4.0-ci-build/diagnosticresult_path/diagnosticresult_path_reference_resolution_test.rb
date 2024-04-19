# frozen_string_literal: true

require_relative '../../../reference_resolution_test'

module AUCoreTestKit
  module AUCoreV040_CI_BUILD
    class DiagnosticresultPathReferenceResolutionTest < Inferno::Test
      include AUCoreTestKit::ReferenceResolutionTest

      title 'MustSupport references within Observation resources are valid'
      description %(
        This test will attempt to read external references provided within elements
        marked as 'MustSupport', if any are available.

        It verifies that at least one external reference for each MustSupport Reference element
        can be accessed by the test client, and conforms to corresponding AU Core profile.

        Elements which may provide external references include:

        * Observation.hasMember
        * Observation.performer
        * Observation.specimen
        * Observation.subject
      )

      id :au_core_v040_ci_build_diagnosticresult_path_reference_resolution_test

      def resource_type
        'Observation'
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:diagnosticresult_path_resources] ||= {}
      end

      run do
        perform_reference_resolution_test(scratch_resources[:all])
      end
    end
  end
end
