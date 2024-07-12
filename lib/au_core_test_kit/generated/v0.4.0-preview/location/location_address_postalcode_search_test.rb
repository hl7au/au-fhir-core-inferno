# frozen_string_literal: true

require_relative '../../../search_test'
require_relative '../../../generator/group_metadata'
require_relative '../../../helpers'

module AUCoreTestKit
  module AUCoreV040_PREVIEW
    class LocationAddressPostalcodeSearchTest < Inferno::Test
      include AUCoreTestKit::SearchTest

      title '(SHOULD) Server returns valid results for Location search by address-postalcode'
      description %(
A server SHOULD support searching by
address-postalcode on the Location resource. This test
will pass if resources are returned and match the search criteria. If
none are returned, the test is skipped.

[AU Core Server CapabilityStatement](http://hl7.org.au/fhir/core//CapabilityStatement-au-core-server.html)

      )

      id :au_core_v040_preview_location_address_postalcode_search_test
      optional

      def self.properties
        @properties ||= SearchTestProperties.new(
          resource_type: 'Location',
          search_param_names: ['address-postalcode']
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
