# frozen_string_literal: true

require 'json'

module AUCoreTestKit
  module Scenarios
    # The versioned suites that get a Scenario, named by their generator config file.
    # The ci-build suite and the validations suite are left out on purpose.
    module Suites
      CONFIG_FILES = %w[config.100.json config.200.json config.210-draft.json config.300-ballot1.json].freeze
      BASIC_CONFIG_FILE = 'config.basic.json'
      ROOT = File.expand_path('../..', __dir__)

      Suite = Data.define(:config_file, :suite_id, :ig_id, :ig_version, :package_path) do
        def scenario_dir
          "spec/fixtures/stub_server/#{suite_id}/"
        end
      end

      def self.all
        @all ||= CONFIG_FILES.map { |file| build(file) }.freeze
      end

      def self.find(suite_id)
        all.find { |suite| suite.suite_id == suite_id } ||
          raise(ArgumentError, "Unknown suite #{suite_id}; known: #{all.map(&:suite_id).join(', ')}")
      end

      # Builds the suite id the way inferno_suite_generator does: "<title>_v<version>", title
      # snake_cased and the version without dots, its dashes turned into underscores.
      def self.build(file)
        basic, config = [BASIC_CONFIG_FILE, file].map { |name| JSON.parse(File.read(File.join(ROOT, name))) }
        title = config.dig('suite', 'title') || basic.dig('suite', 'title')
        version = config.dig('ig', 'version')
        Suite.new(
          config_file: file,
          suite_id: "#{title.downcase.tr(' ', '_')}_v#{version.delete('.').tr('-', '_')}",
          ig_id: config.dig('ig', 'id') || basic.dig('ig', 'id'),
          ig_version: version,
          package_path: config.dig('ig', 'package_archive_path')
        )
      end
      private_class_method :build
    end
  end
end
