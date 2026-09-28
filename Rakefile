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
  desc 'Generate tests (default config.300-ballot1.json; pass a config name, e.g. rake "au_core:generate[ci-build]")'
  task :generate, [:config] do |_task, args|
    if args[:config] == 'ci-build'
      # The ci-build suite tracks the AU Core CI build; see rakelib/ci_build.rb.
      require_relative 'rakelib/ci_build'
      AUCoreTestKit::CIBuild.new.generate
      sh 'bundle', 'exec', 'rubocop', '-A', '--format', 'quiet', AUCoreTestKit::CIBuild::OUTPUT_DIR
      next
    end

    require 'inferno_suite_generator'
    basic_config_file = './config.basic.json'
    config_files = args[:config] ? ["./config.#{args[:config]}.json"] : ['./config.300-ballot1.json']
    config_files.each do |config_file|
      InfernoSuiteGenerator::Generator.generate([basic_config_file, config_file])
    end
  end
end
