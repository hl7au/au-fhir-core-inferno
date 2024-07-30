# frozen_string_literal: true

require_relative '../../../search_test'
require_relative '../../../generator/group_metadata'
require_relative '../../../helpers'

module AUCoreTestKit
  module AUCoreV041_PREVIEW
    class LocationAddressSearchTest < Inferno::Test
      include AUCoreTestKit::SearchTest

      title '(SHALL) Server returns valid results for Location search by address'
      description %(
A server SHALL support searching by
address on the Location resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

Because this is the first search of the sequence, resources in the
response will be used for subsequent tests.

Additionally, this test will check that GET and POST search methods
return the same number of results. Search by POST is required by the
FHIR R4 specification, and these tests interpret search by GET as a
requirement of AU Core v0.4.1-preview.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html)

      )

      id :au_core_v041_preview_location_address_search_test
      input :count_limit,
            title: 'Use _count search parameter for search tests.',
            description: 'If your server has a lot of data, you can decrease the number of resources in server responses by limiting via _count.',
            type: 'radio',
            default: 'false',
            options: {
              list_options: [
                {
                  label: '1',
                  value: '1'
                },
                {
                  label: '10',
                  value: '10'
                },
                {
                  label: '20',
                  value: '20'
                },
                {
                  label: '50',
                  value: '50'
                },
                {
                  label: '100',
                  value: '100'
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
          resource_type: 'Location',
          search_param_names: ['address'],
          saves_delayed_references: true,
          test_post_search: true
        )
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:location_resources] ||= {}
      end

      run do
        run_search_test
      end
    end
  end
end
