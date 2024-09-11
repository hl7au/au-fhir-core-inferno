# frozen_string_literal: true

require_relative 'location/location_read_test'
require_relative 'location/location_address_search_test'
require_relative 'location/location_name_search_test'
require_relative 'location/location_address_city_search_test'
require_relative 'location/location_address_state_search_test'
require_relative 'location/location_address_postalcode_search_test'
require_relative 'location/location_validation_test'
require_relative 'location/location_must_support_test'
require_relative 'location/location_reference_resolution_test'

module AUCoreTestKit
  module AUCoreV100_BALLOT
    class LocationGroup < Inferno::TestGroup
      title 'Location Tests'
      short_description 'Verify support for the server capabilities required by the AU Core Location.'
      description %(
  # Background

The AU Core Location sequence verifies that the system under test is
able to provide correct responses for Location queries. These queries
must contain resources conforming to the AU Core Location as
specified in the AU Core v1.0.0-ballot Implementation Guide.

# Testing Methodology
## Searching
This test sequence will first perform each required search associated
with this resource. This sequence will perform searches with the
following parameters:

* address
* name

### Search Parameters
Resources for this test group can't be found using patient search parameters. This means that in this particular case, the first test will be a read test, not a search. To ensure that this resource will be available for reading, please review the [prerequisites](https://github.com/hl7au/au-fhir-core-inferno/blob/master/docs/pre-requisites.md). Additionally, you can run this test group separately by using specific resource IDs.

### Search Validation
Inferno will retrieve up to the first 20 bundle pages of the reply for
Location resources and save them for subsequent tests. Each of
these resources is then checked to see if it matches the searched
parameters in accordance with [FHIR search
guidelines](https://www.hl7.org/fhir/search.html). The test will fail,
for example, if a Patient search for `gender=male` returns a `female`
patient.


## Must Support
Each profile contains elements marked as "must support". This test
sequence expects to see each of these elements at least once. If at
least one cannot be found, the test will fail. The test will look
through the Location resources found in the first test for these
elements.

## Profile Validation
Each resource returned from the first search is expected to conform to
the [AU Core Location](http://hl7.org.au/fhir/core/StructureDefinition/au-core-location). Each element is checked against
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

      id :au_core_v100_ballot_location
      run_as_group

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'location', 'metadata.yml'), aliases: true))
      end

      test from: :au_core_v100_ballot_location_read_test
      test from: :au_core_v100_ballot_location_address_search_test
      test from: :au_core_v100_ballot_location_name_search_test
      test from: :au_core_v100_ballot_location_address_city_search_test
      test from: :au_core_v100_ballot_location_address_state_search_test
      test from: :au_core_v100_ballot_location_address_postalcode_search_test
      test from: :au_core_v100_ballot_location_validation_test
      test from: :au_core_v100_ballot_location_must_support_test
      test from: :au_core_v100_ballot_location_reference_resolution_test
    end
  end
end
