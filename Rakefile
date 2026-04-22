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
  desc 'Generate tests'
  task :generate do
    require 'inferno_suite_generator'
    basic_config_file = './config.basic.json'
    config_files = ['./config.200.json']
    config_files.each do |config_file|
      InfernoSuiteGenerator::Generator.generate([basic_config_file, config_file])
    end
  end
end
