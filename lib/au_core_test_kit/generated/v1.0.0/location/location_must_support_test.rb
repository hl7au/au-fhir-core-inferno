# frozen_string_literal: true

require 'inferno_suite_generator/must_support_test'

module AUCoreTestKit
  module AUCoreV100
    class LocationMustSupportTest < Inferno::Test
      include InfernoSuiteGenerator::MustSupportTest

      title 'All must support elements are provided in the Location resources returned'
      description %(
        AU Core Responders SHALL be capable of populating all data elements as
        part of the query results as specified by the AU Core Server Capability
        Statement. This test will look through the Location resources
        found previously for the following must support elements:

        * Location.address
        * Location.managingOrganization
        * Location.name
        * Location.physicalType
        * Location.type
      )

      id :au_core_v100_location_must_support_test

      def resource_type
        'Location'
      end

      def self.metadata
        @metadata ||= InfernoSuiteGenerator::Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:location_resources] ||= {}
      end

      run do
        perform_must_support_test(all_scratch_resources)
      end
    end
  end
end
