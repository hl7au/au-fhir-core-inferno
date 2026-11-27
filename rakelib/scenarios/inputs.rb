# frozen_string_literal: true

require 'json'
require 'yaml'
require 'zlib'
require 'rubygems/package'
require_relative 'suites'

module AUCoreTestKit
  module Scenarios
    # Resolves a suite's Scenario inputs: the shared inputs it declares, replaced key by key by `overrides.yml` inputs.
    module Inputs
      class Error < StandardError; end

      SHARED_FILE = File.join(Suites::ROOT, 'spec/fixtures/stub_server/inputs.yml')

      def self.for(suite, overrides_inputs)
        declared = Inferno::Repositories::TestSuites.new.find(suite.suite_id).available_inputs.keys.map(&:to_s)
        inputs = YAML.safe_load_file(SHARED_FILE).slice(*declared).merge(overrides_inputs)
        check_ids(suite, inputs)
        inputs
      end

      def self.check_ids(suite, inputs)
        examples = example_ids(suite.package_path)
        inputs.each do |name, value|
          next unless name.end_with?('_ids')

          type = resource_type(name)
          id = (value.to_s.split(',').map(&:strip) - examples[type]).first
          raise Error, "#{suite.suite_id}: #{name} id \"#{id}\" is not a #{type} example in #{suite.package_path}" if id
        end
      end

      # practitioner_role_ids -> PractitionerRole
      def self.resource_type(name)
        name.delete_suffix('_ids').split('_').map(&:capitalize).join
      end

      # { resourceType => [id, ...] } of the package's package/example/*.json
      def self.example_ids(package_path)
        Zlib::GzipReader.open(File.join(Suites::ROOT, package_path)) do |gz|
          Gem::Package::TarReader.new(gz).each_with_object(Hash.new { |hash, type| hash[type] = [] }) do |entry, ids|
            next unless entry.file? && entry.full_name.match?(%r{\Apackage/example/[^/]+\.json\z})

            resource = JSON.parse(entry.read)
            ids[resource['resourceType']] << resource['id']
          end
        end
      end
      private_class_method :check_ids, :resource_type, :example_ids
    end
  end
end
