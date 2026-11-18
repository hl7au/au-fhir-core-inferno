# frozen_string_literal: true

require 'pry'
require 'pry-byebug'

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:spec)
  task default: :spec
rescue LoadError # rubocop:disable Lint/SuppressedException
end

namespace :db do
  desc 'Apply changes to the database'
  task :migrate do
    require 'inferno/config/application'
    require 'inferno/utils/migration'
    Inferno::Utils::Migration.new.run
  end
end

namespace :au_core do
  desc 'Generate every suite, each in its own process'
  task :generate do
    require_relative 'lib/au_core_test_kit/suite_configs'
    generator_script = 'require "inferno_suite_generator"; InfernoSuiteGenerator::Generator.generate(ARGV)'

    # The generator's GeneratorConfigKeeper shares one hash across configs, so a second
    # config generated in the same process would inherit the first one's settings.
    AUCoreTestKit::SuiteConfigs::VERSIONS.each do |version_file|
      ruby '-e', generator_script, AUCoreTestKit::SuiteConfigs::BASIC, version_file
    end
  end
end
