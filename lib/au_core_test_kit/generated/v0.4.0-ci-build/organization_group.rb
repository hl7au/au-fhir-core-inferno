# frozen_string_literal: true

require_relative 'organization/organization_read_test'
require_relative 'organization/organization_id_search_test'
require_relative 'organization/organization_address_search_test'
require_relative 'organization/organization_identifier_search_test'
require_relative 'organization/organization_name_search_test'
require_relative 'organization/organization_provenance_revinclude_search_test'
require_relative 'organization/organization_validation_test'
require_relative 'organization/organization_must_support_test'

module AUCoreTestKit
  module AUCoreV040_CI_BUILD
    class OrganizationGroup < Inferno::TestGroup
      title 'Organization Tests'
      short_description 'Verify support for the server capabilities required by the AU Core Organization.'
      description %(
  # Background

The AU Core Organization sequence verifies that the system under test is
able to provide correct responses for Organization queries. These queries
must contain resources conforming to the AU Core Organization as
specified in the AU Core v0.4.0-ci-build Implementation Guide.

# Testing Methodology
## Searching
This test sequence will first perform each required search associated
with this resource. This sequence will perform searches with the
following parameters:

* address
* identifier
* name

### Search Parameters
The first search uses the selected patient(s) from the prior launch
sequence. Any subsequent searches will look for its parameter values
from the results of the first search. For example, the `identifier`
search in the patient sequence is performed by looking for an existing
`Patient.identifier` from any of the resources returned in the `_id`
search. If a value cannot be found this way, the search is skipped.

### Search Validation
Inferno will retrieve up to the first 20 bundle pages of the reply for
Organization resources and save them for subsequent tests. Each of
these resources is then checked to see if it matches the searched
parameters in accordance with [FHIR search
guidelines](https://www.hl7.org/fhir/search.html). The test will fail,
for example, if a Patient search for `gender=male` returns a `female`
patient.


## Must Support
Each profile contains elements marked as "must support". This test
sequence expects to see each of these elements at least once. If at
least one cannot be found, the test will fail. The test will look
through the Organization resources found in the first test for these
elements.

## Profile Validation
Each resource returned from the first search is expected to conform to
the [AU Core Organization](http://hl7.org.au/fhir/core/StructureDefinition/au-core-organization). Each element is checked against
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

      id :au_core_v040_ci_build_organization
      run_as_group

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'organization', 'metadata.yml'), aliases: true))
      end

      test from: :au_core_v040_ci_build_organization_read_test
      test from: :au_core_v040_ci_build_organization__id_search_test
      test from: :au_core_v040_ci_build_organization_address_search_test
      test from: :au_core_v040_ci_build_organization_identifier_search_test
      test from: :au_core_v040_ci_build_organization_name_search_test
      test from: :au_core_v040_ci_build_organization_provenance_revinclude_search_test
      test from: :au_core_v040_ci_build_organization_validation_test
      test from: :au_core_v040_ci_build_organization_must_support_test
    end
  end
end
