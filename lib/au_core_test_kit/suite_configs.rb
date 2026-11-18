# frozen_string_literal: true

require 'json'
require 'rubygems/package'
require 'zlib'

module AUCoreTestKit
  # The config files `au_core:generate` combines: each version file, merged over
  # the basic file, generates one suite.
  module SuiteConfigs
    ROOT = File.expand_path('../..', __dir__)
    BASIC = 'config.basic.json'
    VERSIONS = %w[
      config.100.json
      config.200.json
      config.210-draft.json
      config.300-ballot1.json
    ].freeze

    # One version file merged over the basic file, plus what it generates.
    class Entry
      attr_reader :version_file, :merged

      def initialize(version_file)
        @version_file = version_file
        @merged = SuiteConfigs.deep_merge(SuiteConfigs.read_json(BASIC), SuiteConfigs.read_json(version_file))
      end

      def ig_version
        merged.dig('ig', 'version')
      end

      def suite_id
        "au_core_v#{ig_version.delete('.').tr('-', '_')}"
      end

      def generated_dir
        File.join(ROOT, 'lib', 'au_core_test_kit', 'generated', "v#{ig_version}")
      end

      def capability_statement
        @capability_statement ||= SuiteConfigs.find_in_package(
          File.join(ROOT, merged.dig('ig', 'package_archive_path')),
          merged.dig('ig', 'cs_profile_url')
        )
      end
    end

    module_function

    def entries
      VERSIONS.map { |version_file| Entry.new(version_file) }
    end

    def each(&)
      entries.each(&)
    end

    def read_json(relative_path)
      JSON.parse(File.read(File.join(ROOT, relative_path)))
    end

    # Merged into a fresh hash on every call, not through the generator's
    # GeneratorConfigKeeper: its instances share one hash, so a second config
    # loaded in the same process inherits keys from the first.
    def deep_merge(base, override)
      base.merge(override) do |_key, base_value, override_value|
        base_value.is_a?(Hash) && override_value.is_a?(Hash) ? deep_merge(base_value, override_value) : override_value
      end
    end

    def find_in_package(archive_path, url)
      Zlib::GzipReader.open(archive_path) do |gzip|
        Gem::Package::TarReader.new(gzip) do |tar|
          tar.each do |file|
            next unless file.file? && file.full_name.end_with?('.json')

            resource = JSON.parse(file.read)
            return resource if resource.is_a?(Hash) && resource['url'] == url
          rescue JSON::ParserError
            next
          end
        end
      end
      raise ArgumentError, "No resource with url #{url} in #{archive_path}"
    end
  end
end
