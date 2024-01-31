# 0.6.2

* FHIR-2327: Restore component.dataAbsentReason MS for BloodPressure profile by @yunwwang in https://github.com/inferno-framework/us-core-test-kit/pull/141
* FI-2313: MS Slice Subelement Support by @360dgries in https://github.com/inferno-framework/us-core-test-kit/pull/140
* FI-2348: Add guard for fixed values on slice discriminators by @360dgries in https://github.com/inferno-framework/us-core-test-kit/pull/143
* FI-2316: Label Reference target profile as MustSupport as there is only one by @yunwwang in https://github.com/inferno-framework/us-core-test-kit/pull/139

# 0.6.1

* Fix broken link to US Core 6.1.0 IG by @Justin-Ramm in
  https://github.com/inferno-framework/us-core-test-kit/pull/130
* FI-2212 Fix _include search for MedicationDispense by @yunwwang in
  https://github.com/inferno-framework/us-core-test-kit/pull/132
* FI-2163 Update CapabilityStatement Test 1.05 for supported profile by
  @yunwwang in https://github.com/inferno-framework/us-core-test-kit/pull/133
* FI-2240 Fix non-root deployment on US Core by @arscan in
  https://github.com/inferno-framework/us-core-test-kit/pull/134
* FI-2240 Compare references in Medication include test result by @yunwwang in
  https://github.com/inferno-framework/us-core-test-kit/pull/135
* FI-2104: Remove resource list by @Jammjammjamm in
  https://github.com/inferno-framework/us-core-test-kit/pull/136
* FI-2268 Merge reference_test_spec and reference_resolution_test_spec by
  @360dgries in https://github.com/inferno-framework/us-core-test-kit/pull/137

# 0.6.0

* Add test suite for US Core 6.1.0
* Remove test suite for US Core 6.0.0

# 0.5.0

* Add test suite for US Core 6.0.0.

# 0.4.7

* Updated Patient MustSupport tests for previous name and address. See #114 for
  details.
* Fix a bug which prevented the tests from finding search parameter values in
  extensions, which is needed for searching Conditions by asserted date in US
  Core 5.

# 0.4.6

* Fix the `ServiceRequest.category` ValueSet expansion for US Core 5.
* Remove tests for Device UDI-PI presence from US Core 4 & 5.
* Fix a bug in US Core 4 and 5 which removed
  `MedicationRequest.reportedReference` from the list of Must Support
  references.

# 0.4.5

* Update the validator message filter for SMART extensions to support a new
  validator version.
* Update the profile support test to no longer issue warnings based on which
  profiles are supported, and to allow a list of resources which must be
  supported.

# 0.4.4

* Update the title and description of Must Support tests.
* Update the reference resolution tests to track which profiles a reference was
  validated against so that those references don't need to be validated multiple
  times against the same profile.

# 0.4.3

* Fix status values not being included in metadata for fields whose exact name
  isn't `status` (e.g. `clinicalStatus`) (#98).

# 0.4.2

* Update to support new development workflow (#92).
* Remove unneeded search values from metadata (#91).
* Remove optional patternCodeableConcept values from search definition metadata
  to avoid retrieving resources which conform to a different profile than the
  one being tested (#93).
* Add a description to the generated suites (#89).
* Update to handle mandatory slices with required bindings in US Core 5 (#94).
* Update US Core 5 Provenance tests to handle broken provenance-1 constraint
  (#95).

# 0.4.1

* Fix a bug which prevented slices by binding from being correctly identified in
  MustSupport tests (only affects US Core 5) (#88).
* Remove DocumentReference.custodian from the MustSupport test in US Core 3.1.1
  (#84).

# 0.4.0

* Update to a new version of inferno_core based on Ruby 3 (#83).
* Fix a bug caused by escaped commas in search parameters (#85).
* Add support for `fhir_validator_wrapper` version 2.2.0 (#86).

# 0.3.2

* Fix MustSupport requirements for representing a Patient's previous name in US
  Core 4 & 5.
* Fix date comparator searches to account for server time zones.

# 0.3.1

* Fix a typo when no resources are found.
* Prevent validation errors from appearing on reference resolution tests.
* Add optional group for QuestionnaireResponse in US Core 5.
* Fix a nil-safety issue in reference resolution tests.
* Remove QuestionnaireResponse from the list of Must Support target profiles for
  US Core Observation Survey and US Core SDOH Assessment (US Core 5).
* Fix a bug which incorrectly marked SmokingStatus searches by patient +
  category + date as optional (US Core 4 & 5).

# 0.3.0

* Add US Core v5.0.1 tests.

# 0.2.5

* Include the profile version in validation calls so a single validator instance
  can be used for multiple US Core versions.
* Fix a bug where incorrect resources were being checked in searches with
  comparators.
* Remove USCDI-only label from subfields of Patient.telecom and
  Patient.communication (US Core 4+).
* Add Must Support test for dateTime slices (US Core 5+).

# 0.2.4

* Add info message when resource with an unexpected type is included in the
  Bundle response to a search.
* Update validation message filters.

# 0.2.3

* Update testing logic for Patient's previous name MustSupport test.
* Separate USCDI requirements into 'Additional USCDI requirements' section.
* Fix logic in search test when generating search values for Encounter status search.
* Add logic for increased date and time precision in date search tests.
* Remove validation of resource types returned in the Bundles returned by search requests.
* Allow search value extraction from array element when first item is DAR extension.
* Remove US Core Organization Profile from must support checking of Provenance.agent.who.
* Improve search value generation by extracting values from one resource, if possible.
* Alter device search to filter returned resources by Device Type Code input.

# 0.2.2

* Omit medication resource validation if no medication resources provided.
* Fix failure when Clinical Note Reference test finds non-matched reference.
* Update Clinical Note Type test to not save attachment without url and filter DiagnosticReport with required categories only.

# 0.2.1

* Update reference resolution test descriptions in groups to describe the new
  behavior from v0.2.0.
* Remove reference resolution tests for resources with no Must Support
  references.

# 0.2.0

* Add US Core v4.0.0 tests.
* Modify reference resolution tests to only check Must Support references.
* Update reference resolution test to store requests.
* Fix string interpolation in reference search checks.
* Fix error message in read tests when id does not match.

# 0.1.1

* Add .yml files to published gem.
# 0.1.0

* Initial public release.
