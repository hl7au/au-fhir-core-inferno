# frozen_string_literal: true

require 'json'
require 'open3'
require 'fhir_stub_server'
require_relative 'suites'

module AUCoreTestKit
  module Scenarios
    # Runs a suite in a child `inferno execute` against a Stub Server served over HTTP.
    class Runner
      class Error < StandardError; end

      Run = Data.define(:stub, :results)

      ENTRY_SCRIPT = File.expand_path('inferno_execute.rb', __dir__)
      # 3 means the run finished but not every result is a pass.
      FINISHED_STATUSES = [0, 3].freeze

      # Without `groups` the whole suite runs as one test session, so its groups share scratch.
      # `groups` (short ids) is only for fast specs and debugging.
      def run(suite_id:, inputs:, server:, dir:, groups: nil)
        # An empty validator block keeps validator calls on the Stub, where they show up as misses.
        stub = FHIRStubServer::Stub.new({ 'validator' => { 'pairs' => [] } }.merge(server), dir:)
        http = FHIRStubServer::HTTPServer.new(stub)
        base_url = http.start
        stdout, stderr, status = Open3.capture3(
          { 'APP_ENV' => 'test', 'FHIR_RESOURCE_VALIDATOR_URL' => "#{base_url}/validator" },
          RbConfig.ruby, ENTRY_SCRIPT, *arguments(suite_id, inputs.merge('url' => "#{base_url}/fhir"), groups),
          chdir: Suites::ROOT
        )
        return Run.new(stub:, results: results(stdout)) if FINISHED_STATUSES.include?(status.exitstatus)

        raise Error, "inferno execute --suite #{suite_id} exited #{status.exitstatus}\n#{stdout}\n#{stderr}"
      ensure
        http&.stop
      end

      private

      def arguments(suite_id, inputs, groups)
        ['--suite', suite_id, '--outputter', 'json', '--inputs', *inputs.map { |name, value| "#{name}:#{value}" },
         *(['--groups', *groups] if groups)]
      end

      # Entries without a test_id are group results.
      def results(stdout)
        JSON.parse(stdout).filter_map { |result| [result['test_id'], result['result']] if result['test_id'] }.to_h
      end
    end
  end
end
