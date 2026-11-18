# frozen_string_literal: true

require_relative '../../lib/au_core_test_kit/suite_configs'

module SuiteRuleHelpers
  def suite_for(entry)
    Inferno::Repositories::TestSuites.new.find(entry.suite_id)
  end

  # The groups built from a CapabilityStatement resource; custom groups have no metadata.
  def generated_groups(runnable)
    runnable.groups.flat_map do |group|
      own = group.respond_to?(:metadata) ? [group] : []
      own + generated_groups(group)
    end
  end

  # Inferno ids carry the whole parent path, joined with '-'.
  def short_id(runnable)
    runnable.id.split('-').last
  end
end
