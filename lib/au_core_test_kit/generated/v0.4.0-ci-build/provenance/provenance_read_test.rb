# frozen_string_literal: true

require_relative '../../../read_test'

module AUCoreTestKit
  module AUCoreV040_CI_BUILD
    class ProvenanceReadTest < Inferno::Test
      include AUCoreTestKit::ReadTest

      title 'Server returns correct Provenance resource from Provenance read interaction'
      description 'A server SHALL support the Provenance read interaction.'

      id :au_core_v040_ci_build_provenance_read_test

      def resource_type
        'Provenance'
      end

      def scratch_resources
        scratch[:provenance_resources] ||= {}
      end

      run do
        perform_read_test(all_scratch_resources)
      end
    end
  end
end
