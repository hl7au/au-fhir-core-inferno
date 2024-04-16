require_relative 'provenance/provenance_read_test'
require_relative 'provenance/provenance_validation_test'
require_relative 'provenance/provenance_must_support_test'
require_relative 'provenance/provenance_reference_resolution_test'

module AUCoreTestKit
  module AUCoreV030_BALLOT
    class ProvenanceGroup < Inferno::TestGroup
      title 'Provenance Tests'
      short_description 'Verify support for the server capabilities required by the AU Core Provenance.'
      description %(
  # Background

The AU Core Provenance sequence verifies that the system under test is
able to provide correct responses for Provenance queries. These queries
must contain resources conforming to the AU Core Provenance as
specified in the AU Core v0.3.0-ballot Implementation Guide.

# Testing Methodology


## Must Support
Each profile contains elements marked as "must support". This test
sequence expects to see each of these elements at least once. If at
least one cannot be found, the test will fail. The test will look
through the Provenance resources found in the first test for these
elements.

## Profile Validation
Each resource returned from the first search is expected to conform to
the [AU Core Provenance](http://hl7.org.au/fhir/core/StructureDefinition/au-core-provenance). Each element is checked against
teminology binding and cardinality requirements.

Elements with a required binding are validated against their bound
ValueSet. If the code/system in the element is not part of the ValueSet,
then the test will fail.

## Reference Validation
At least one instance of each external reference in elements marked as
"must support" within the resources provided by the system must resolve.
The test will attempt to read each reference found and will fail if no
read succeeds.

      )

      id :au_core_v030_ballot_provenance
      run_as_group

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'provenance', 'metadata.yml'),
                                                                  aliases: true))
      end

      test from: :au_core_v030_ballot_provenance_read_test
      test from: :au_core_v030_ballot_provenance_validation_test
      test from: :au_core_v030_ballot_provenance_must_support_test
      test from: :au_core_v030_ballot_provenance_reference_resolution_test
    end
  end
end
