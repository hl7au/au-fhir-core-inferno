# frozen_string_literal: true

# `inferno execute ARGV` for Scenario specs. The test config's database is SQLite in memory,
# which nothing migrates in a fresh process, so migrate it first, as spec_helper.rb does.
require 'inferno/config/application'
require 'inferno/utils/migration'
Inferno::Utils::Migration.new.run

require 'inferno/apps/cli'
require_relative 'scenario'

# Builds the Scenario's group (see Scenario#scenario_group) once the kit's suites are loaded,
# before `inferno execute` looks its short id up.
module BuildScenarioGroup
  def boot_full_inferno
    super
    scenario = Scenario.new(ENV.fetch('SCENARIO'))
    scenario.scenario_group(Inferno::Repositories::TestSuites.new.find(scenario.suite_id))
  end
end
Inferno::CLI::Execute.singleton_class.prepend(BuildScenarioGroup)

Inferno::CLI::Main.start(['execute', *ARGV])
