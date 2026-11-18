# frozen_string_literal: true

require_relative '../../support/suite_rule_helpers'

RSpec.describe 'Suite Rule: read and search tests follow the CapabilityStatement' do
  include SuiteRuleHelpers

  def combination_url
    'http://hl7.org/fhir/StructureDefinition/capabilitystatement-search-parameter-combination'
  end

  def search_test_id(group, names)
    "#{short_id(group)}_#{names.map { |name| name.tr('-', '_') }.join('_')}_search_test"
  end

  def read_test_ids(group, resource)
    readable = Array(resource['interaction']).any? { |interaction| interaction['code'] == 'read' }
    readable ? ["#{short_id(group)}_read_test"] : []
  end

  def single_search_test_ids(group, resource, ignored_params)
    names = Array(resource['searchParam']).map { |param| param['name'] } - ignored_params
    names.map { |name| search_test_id(group, [name]) }
  end

  def combination_search_test_ids(group, resource)
    Array(resource['extension']).select { |ext| ext['url'] == combination_url }.map do |combination|
      required = Array(combination['extension']).select { |ext| ext['url'] == 'required' }
      search_test_id(group, required.map { |ext| ext['valueString'] })
    end
  end

  def expected_test_ids(group, resource, ignored_params)
    read_test_ids(group, resource) +
      single_search_test_ids(group, resource, ignored_params) +
      combination_search_test_ids(group, resource)
  end

  AUCoreTestKit::SuiteConfigs.each do |entry|
    it "holds for #{entry.suite_id}" do
      ignored_params = entry.merged.dig('configs', 'generic', 'search_params_to_ignore') || []
      resources = entry.capability_statement.dig('rest', 0, 'resource').to_h { |resource| [resource['type'], resource] }

      missing = generated_groups(suite_for(entry)).flat_map do |group|
        actual = group.tests.map { |test| short_id(test) }
        expected_test_ids(group, resources.fetch(group.metadata.resource), ignored_params) - actual
      end

      expect(missing).to be_empty, "#{entry.suite_id} is missing tests: #{missing.join(', ')}"
    end
  end
end
