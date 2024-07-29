# frozen_string_literal: true

require_relative '../../../search_test'
require_relative '../../../generator/group_metadata'
require_relative '../../../helpers'

module AUCoreTestKit
  module AUCoreV050_CI_BUILD
    class PatientIdSearchTest < Inferno::Test
      include AUCoreTestKit::SearchTest

      title '(SHALL) Server returns valid results for Patient search by _id'
      description %(
A server SHALL support searching by
_id on the Patient resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

Because this is the first search of the sequence, resources in the
response will be used for subsequent tests.

Additionally, this test will check that GET and POST search methods
return the same number of results. Search by POST is required by the
FHIR R4 specification, and these tests interpret search by GET as a
requirement of AU Core v0.5.0-ci-build.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html)

      )

      id :au_core_v050_ci_build_patient__id_search_test
      input :patient_ids,
            title: 'Patient IDs',
            description: 'Comma separated list of patient IDs that in sum contain all MUST SUPPORT elements',
            default: 'baratz-toni, irvine-ronny-lawrence, italia-sofia, howe-deangelo, hayes-arianne, baby-banks-john, banks-mia-leanne'

      input :use_read_instead_of_search,
            title: 'Use read instead of search?',
            description: 'For cases when the search by _id for the Patient is not available, the search test will fail, but data from the read test will be available.',
            type: 'radio',
            default: 'false',
            options: {
              list_options: [
                {
                  label: 'True',
                  value: 'true'
                },
                {
                  label: 'False',
                  value: 'false'
                }
              ]
            }

      def self.properties
        @properties ||= SearchTestProperties.new(
          first_search: true,
          resource_type: 'Patient',
          search_param_names: ['_id'],
          possible_status_search: true,
          test_post_search: true
        )
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:patient_resources] ||= {}
      end

      run do
        run_search_test
      end
    end
  end
end
