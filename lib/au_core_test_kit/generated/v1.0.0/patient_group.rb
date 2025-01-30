# frozen_string_literal: true

require_relative 'patient/patient_id_search_test'
require_relative 'patient/patient_birthdate_search_test'
require_relative 'patient/patient_family_search_test'
require_relative 'patient/patient_gender_search_test'
require_relative 'patient/patient_indigenous_status_search_test'
require_relative 'patient/patient_identifier_search_test'
require_relative 'patient/patient_name_search_test'
require_relative 'patient/patient_gender_identity_search_test'
require_relative 'patient/patient_birthdate_family_search_test'
require_relative 'patient/patient_birthdate_name_search_test'
require_relative 'patient/patient_family_gender_search_test'
require_relative 'patient/patient_gender_name_search_test'
require_relative 'patient/patient_indigenous_status_multiple_or_search_test'
require_relative 'patient/patient_gender_identity_multiple_or_search_test'
require_relative 'patient/patient_birthdate_multiple_and_search_test'
require_relative 'patient/patient_indigenous_status_multiple_and_search_test'
require_relative 'patient/patient_gender_identity_multiple_and_search_test'
require_relative 'patient/patient_identifier_ihi_search_test'
require_relative 'patient/patient_identifier_medicare_search_test'
require_relative 'patient/patient_identifier_dva_search_test'
require_relative 'patient/patient_read_test'
require_relative 'patient/patient_validation_test'
require_relative 'patient/patient_must_support_test'

module AUCoreTestKit
  module AUCoreV100
    class PatientGroup < Inferno::TestGroup
      title 'Patient Tests'
      short_description 'Verify support for the server capabilities required by the AU Core Patient.'
      description %(
  # Background

The AU Core Patient sequence verifies that the system under test is
able to provide correct responses for Patient queries. These queries
must contain resources conforming to the AU Core Patient as
specified in the AU Core v1.0.0 Implementation Guide.

# Testing Methodology
## Searching
This test sequence will first perform each required search associated
with this resource. This sequence will perform searches with the
following parameters:

* _id
* identifier

### Search Parameters
The first search uses the selected patient(s) from the prior launch sequence. Any subsequent searches will look for its parameter values from the results of the first search. For example, the `identifier` search in the patient sequence is performed by looking for an existing `Patient.identifier` from any of the resources returned in the `_id` search. If a value cannot be found this way, the search is skipped.

### Search Validation
Inferno will retrieve up to the first 20 bundle pages of the reply for
Patient resources and save them for subsequent tests. Each of
these resources is then checked to see if it matches the searched
parameters in accordance with [FHIR search
guidelines](https://www.hl7.org/fhir/search.html). The test will fail,
for example, if a Patient search for `gender=male` returns a `female`
patient.


## Must Support
Each profile contains elements marked as "must support". This test
sequence expects to see each of these elements at least once. If at
least one cannot be found, the test will fail. The test will look
through the Patient resources found in the first test for these
elements.

## Profile Validation
Each resource returned from the first search is expected to conform to
the [AU Core Patient](http://hl7.org.au/fhir/core/StructureDefinition/au-core-patient). Each element is checked against
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

      id :au_core_v100_patient
      run_as_group

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'patient', 'metadata.yml'), aliases: true))
      end

      test from: :au_core_v100_patient__id_search_test
      test from: :au_core_v100_patient_birthdate_search_test
      test from: :au_core_v100_patient_family_search_test
      test from: :au_core_v100_patient_gender_search_test
      test from: :au_core_v100_patient_indigenous_status_search_test
      test from: :au_core_v100_patient_identifier_search_test
      test from: :au_core_v100_patient_name_search_test
      test from: :au_core_v100_patient_gender_identity_search_test
      test from: :au_core_v100_patient_birthdate_family_search_test
      test from: :au_core_v100_patient_birthdate_name_search_test
      test from: :au_core_v100_patient_family_gender_search_test
      test from: :au_core_v100_patient_gender_name_search_test
      test from: :au_core_v100_patient_indigenous_status_multiple_or_search_test
      test from: :au_core_v100_patient_gender_identity_multiple_or_search_test
      test from: :au_core_v100_patient_birthdate_multiple_and_search_test
      test from: :au_core_v100_patient_indigenous_status_multiple_and_search_test
      test from: :au_core_v100_patient_gender_identity_multiple_and_search_test
      test from: :au_core_v100_patient_identifier_ihi_search_test
      test from: :au_core_v100_patient_identifier_medicare_search_test
      test from: :au_core_v100_patient_identifier_dva_search_test
      test from: :au_core_v100_patient_read_test
      test from: :au_core_v100_patient_validation_test
      test from: :au_core_v100_patient_must_support_test
    end
  end
end
