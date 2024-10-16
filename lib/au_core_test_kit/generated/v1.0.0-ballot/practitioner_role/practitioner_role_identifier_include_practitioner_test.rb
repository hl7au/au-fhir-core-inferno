# frozen_string_literal: true

require_relative '../../../search_test'
require_relative '../../../generator/group_metadata'
require_relative '../../../helpers'

module AUCoreTestKit
  module AUCoreV100_BALLOT
    class PractitionerRoleIdentifierIncludePractitionerTest < Inferno::Test
      include AUCoreTestKit::SearchTest
      title 'Server returns Practitioner resources from PractitionerRole search by identifier and PractitionerRole:practitioner'
      description %(
This test will perform a search by identifier and the _include=PractitionerRole:practitioner

Test will pass if a Practitioner resources are found in the response.

      )

      id :au_core_v100_ballot_practitioner_role_identifier_include_identifier_search_test
      optional

      input :patient_ids,
            title: 'Patient IDs',
            description: 'Comma separated list of patient IDs that in sum contain all MUST SUPPORT elements',
            default: 'baratz-toni, irvine-ronny-lawrence, italia-sofia, howe-deangelo, hayes-arianne, baby-banks-john, banks-mia-leanne'

      def self.properties
        @properties ||= SearchTestProperties.new(
          resource_type: 'PractitionerRole',
          search_param_names: ['identifier'],
          includes: [{ 'parameter' => 'PractitionerRole:practitioner', 'target_resource' => 'Practitioner', 'paths' => ['practitioner'] }],
          use_any_data_for_search: true
        )
      end

      def self.metadata
        @metadata ||= Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'metadata.yml'), aliases: true))
      end

      def scratch_resources
        scratch[:practitioner_role_resources] ||= {}
      end

      run do
        run_include_test
      end
    end
  end
end
