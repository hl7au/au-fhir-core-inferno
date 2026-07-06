# frozen_string_literal: true

require 'inferno_suite_generator/core/ig_demodata'
require_relative 'endpoint/endpoint_read_test'
require_relative 'endpoint/endpoint_id_search_test'
require_relative 'endpoint/endpoint_status_search_test'
require_relative 'endpoint/endpoint_connection_type_search_test'
require_relative 'endpoint/endpoint_payload_type_search_test'
require_relative 'endpoint/endpoint_name_search_test'
require_relative 'endpoint/endpoint_validation_test'
require_relative 'endpoint/endpoint_must_support_test'

module AUCoreTestKit
  module AUCoreV210_DRAFT
    class EndpointGroup < Inferno::TestGroup
      title 'Endpoint Tests'
      short_description 'Verify support for the server capabilities required by the AU Core Endpoint.'
      description %(
  # Background

The AU Core Endpoint sequence verifies that the system under test is
able to provide correct responses for Endpoint queries. These queries
must contain resources conforming to the AU Core Endpoint as
specified in the AU Core v2.1.0-draft Implementation Guide.

# Testing Methodology


## Must Support
Each profile contains elements marked as "must support". This test
sequence expects to see each of these elements at least once. If at
least one cannot be found, the test will fail. The test will look
through the Endpoint resources found in the first test for these
elements.

## Profile Validation
Each resource returned from the first search is expected to conform to
the [AU Core Endpoint](http://hl7.org.au/fhir/core/StructureDefinition/au-core-endpoint). Each element is checked against
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

      id :au_core_v210_draft_endpoint
      run_as_group

      def self.metadata
        @metadata ||= InfernoSuiteGenerator::Generator::GroupMetadata.new(YAML.load_file(File.join(__dir__, 'endpoint', 'metadata.yml'), aliases: true))
      end

      test from: :au_core_v210_draft_endpoint_read_test
      test from: :au_core_v210_draft_endpoint__id_search_test
      test from: :au_core_v210_draft_endpoint_status_search_test
      test from: :au_core_v210_draft_endpoint_connection_type_search_test
      test from: :au_core_v210_draft_endpoint_payload_type_search_test
      test from: :au_core_v210_draft_endpoint_name_search_test
      test from: :au_core_v210_draft_endpoint_validation_test
      test from: :au_core_v210_draft_endpoint_must_support_test
    end
  end
end
