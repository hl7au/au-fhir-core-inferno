# frozen_string_literal: true

require_relative '../../../lib/au_core_test_kit/suite_configs'

RSpec.describe 'Suite Rule: every interactive CapabilityStatement resource has a group' do
  def groups_within(runnable)
    runnable.groups.flat_map { |group| [group, *groups_within(group)] }
  end

  # Entries with no interaction (e.g. Specimen, CareTeam) only name a profile for
  # referenced resources; the generator builds no group for them.
  def resource_types_needing_a_group(entry)
    entry.capability_statement.dig('rest', 0, 'resource').filter_map do |resource|
      next if Array(resource['interaction']).empty? || skipped_in_config?(entry.merged, resource)

      resource['type']
    end
  end

  def skipped_in_config?(config, resource)
    resource_config = config.dig('configs', 'resources', resource['type']) || {}
    profile_config = config.dig('configs', 'profiles', resource['profile']) || {}

    [resource_config['skip'], resource_config['skip_generation'], profile_config['skip']].any?
  end

  AUCoreTestKit::SuiteConfigs.each do |entry|
    it "holds for #{entry.suite_id}" do
      suite = Inferno::Repositories::TestSuites.new.find(entry.suite_id)
      covered = groups_within(suite).select { |group| group.respond_to?(:metadata) }.map { |group| group.metadata.resource }

      missing = resource_types_needing_a_group(entry) - covered

      expect(missing).to be_empty, "#{entry.suite_id} has no group for: #{missing.join(', ')}"
    end
  end
end
