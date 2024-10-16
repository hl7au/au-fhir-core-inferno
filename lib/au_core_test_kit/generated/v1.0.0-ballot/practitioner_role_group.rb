# frozen_string_literal: true

require_relative 'practitioner_role/practitioner_role_read_test'
require_relative 'practitioner_role/practitioner_role_id_search_test'
require_relative 'practitioner_role/practitioner_role_identifier_search_test'
require_relative 'practitioner_role/practitioner_role_practitioner_search_test'
require_relative 'practitioner_role/practitioner_role_specialty_search_test'
require_relative 'practitioner_role/practitioner_role_practitioner_multiple_or_search_test'
require_relative 'practitioner_role/practitioner_role_practitioner_multiple_and_search_test'
require_relative 'practitioner_role/practitioner_role_practitioner_chain_search_test'
require_relative 'practitioner_role/practitioner_role_identifier_medicare_search_test'
require_relative 'practitioner_role/practitioner_role_id_include_practitioner_test'
require_relative 'practitioner_role/practitioner_role_identifier_include_practitioner_test'
require_relative 'practitioner_role/practitioner_role_practitioner_include_practitioner_test'
require_relative 'practitioner_role/practitioner_role_specialty_include_practitioner_test'
require_relative 'practitioner_role/practitioner_role_validation_test'
require_relative 'practitioner_role/practitioner_role_must_support_test'
require_relative 'practitioner_role/practitioner_role_reference_resolution_test'

module AUCoreTestKit
  module AUCoreV100_BALLOT
    class PractitionerRoleGroup < Inferno::TestGroup
      title 'PractitionerRole Tests'
      short_description 'Verify support for the server capabilities required by the AU Core PractitionerRole.'
      description %(
  # Background

The AU Core PractitionerRole sequence verifies that the system under test is
able to provide correct responses for PractitionerRole queries. These queries
must contain resources conforming to the AU Core PractitionerRole as
specified in the AU Core v1.0.0-ballot Implementation Guide.

# Testing Methodology
## Searching
This test sequence will first perform each required search associated
with this resource. This sequence will perform searches with the
following parameters:

* _id
* identifier
* practitioner

### Search Parameters
Resources for this test group can't be found using patient search parameters. This means that in this particular case, the first test will be a read test, not a search. To ensure that this resource will be available for reading, please review the [prerequisites](https://github.com/hl7au/au-fhir-core-inferno/blob/master/docs/pre-requisites.md). Additionally, you can run this test group separately by using specific resource IDs.

### Search Validation
Inferno will retrieve up to the first 20 bundle pages of the reply for
PractitionerRole resources and save them for subsequent tests. Each of
these resources is then checked to see if it matches the searched
parameters in accordance with [FHIR search
guidelines](https://www.hl7.org/fhir/search.html). The test will fail,
for example, if a Patient search for `gender=male` returns a `female`
patient.


## Must Support
Each profile contains elements marked as "must support". This test
sequence expects to see each of these elements at least once. If at
least one cannot be found, the test will fail. The test will look
through the PractitionerRole resources found in the first test for these
elements.

## Profile Validation
Each resource returned from the first search is expected to conform to
the [AU Core PractitionerRole](http://hl7.org.au/fhir/core/StructureDefinition/au-core-practitionerrole). Each element is checked against
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

      id :au_core_v100_ballot_practitioner_role
      run_as_group

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'practitioner_role', 'metadata.yml'), aliases: true))
      end

      test from: :au_core_v100_ballot_practitioner_role_read_test
      test from: :au_core_v100_ballot_practitioner_role__id_search_test
      test from: :au_core_v100_ballot_practitioner_role_identifier_search_test
      test from: :au_core_v100_ballot_practitioner_role_practitioner_search_test
      test from: :au_core_v100_ballot_practitioner_role_specialty_search_test
      test from: :au_core_v100_ballot_practitioner_role_practitioner_multiple_or_search_test
      test from: :au_core_v100_ballot_practitioner_role_practitioner_multiple_and_search_test
      test from: :au_core_v100_ballot_practitioner_role_practitioner_chain_search_test
      test from: :au_core_v100_ballot_practitioner_role_identifier_medicare_search_test
      test from: :au_core_v100_ballot_practitioner_role__id_include__id_search_test
      test from: :au_core_v100_ballot_practitioner_role_identifier_include_identifier_search_test
      test from: :au_core_v100_ballot_practitioner_role_practitioner_include_practitioner_search_test
      test from: :au_core_v100_ballot_practitioner_role_specialty_include_specialty_search_test
      test from: :au_core_v100_ballot_practitioner_role_validation_test
      test from: :au_core_v100_ballot_practitioner_role_must_support_test
      test from: :au_core_v100_ballot_practitioner_role_reference_resolution_test
    end
  end
end
