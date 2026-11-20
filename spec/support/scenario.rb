# frozen_string_literal: true

require 'fhir_stub_server'
require 'json'
require 'open3'
require 'yaml'

# One spec/fixtures/stub_server/<name>/scenario.yml: which groups of a suite to run, their
# inputs and the result each test should get. FHIRStubServer.load reads only its `server:` block.
class Scenario
  ROOT = File.expand_path('../..', __dir__)
  DIR = File.join(ROOT, 'spec', 'fixtures', 'stub_server')
  FHIR_BASE_URL = 'http://fhir.stub.test/fhir'

  # What one run left behind: the Stub with its reports, and each test's result by short id.
  Run = Struct.new(:stub, :results) do
    def unmatched_report
      stub.unmatched_report
    end

    def context_mismatch_report
      stub.context_mismatches.map do |mismatch|
        "Validator #{mismatch[:key]}: expected #{mismatch[:expected].inspect}, got #{mismatch[:actual].inspect}"
      end.join("\n")
    end
  end

  def self.all
    Dir[File.join(DIR, '*', 'scenario.yml')].sort.map { |path| new(path) }
  end

  # Test results as { short id => result } from [test id, result] pairs; group results have no
  # test id. Inferno ids carry the whole parent path, joined with '-'.
  def self.by_short_id(test_ids_and_results)
    test_ids_and_results.select(&:first).to_h.transform_keys { |test_id| test_id.split('-').last }
  end

  attr_reader :path

  def initialize(path)
    @path = path
    @config = YAML.safe_load_file(path)
  end

  def name
    File.basename(File.dirname(path))
  end

  def suite_id
    @config.fetch('suite_id')
  end

  # The Scenario's inputs plus `url`, the FHIR base URL each mode serves the Stub at.
  def inputs_with(fhir_base_url)
    @config.fetch('inputs').to_h.merge('url' => fhir_base_url)
  end

  # Test short id => pass, fail, skip, omit or error.
  def expected
    @config.fetch('expected').to_h
  end

  # A new Stub each call, so every run starts with empty reports.
  def stub
    FHIRStubServer.load(path)
  end

  def groups_in(suite)
    @config.fetch('groups').map do |group_id|
      find_group(suite, group_id) or raise ArgumentError, "#{path}: #{suite_id} has no group #{group_id}"
    end
  end

  # Runs the groups in a child `inferno execute` against the Stub over HTTP. Memoized: the
  # child boots the whole kit, and its results don't depend on the calling example.
  def execute_run(suite)
    @execute_run ||= begin
      stub = self.stub
      Run.new(stub, with_http_server(stub) { |base_url| execute(suite, base_url) })
    end
  end

  private

  # Stops the server on the way out without an `ensure`: rubocop 1.63 prints a rubocop-ast
  # deprecation backtrace for every `ensure` it inspects.
  def with_http_server(stub)
    server = FHIRStubServer::HTTPServer.new(stub)
    result = yield server.start
    server.stop
    result
  rescue StandardError
    server&.stop
    raise
  end

  def find_group(runnable, group_id)
    runnable.groups.each do |group|
      return group if group.id == group_id || group.id.end_with?("-#{group_id}")

      found = find_group(group, group_id)
      return found if found
    end
    nil
  end

  def execute(suite, base_url)
    env = { 'APP_ENV' => 'test', 'FHIR_RESOURCE_VALIDATOR_URL' => "#{base_url}/validator" }
    stdout, stderr, status = Open3.capture3(env, *execute_command(suite, base_url), chdir: ROOT)
    # inferno execute exits 0 when every result passes and 3 otherwise; anything else is a crash.
    raise "inferno execute exited #{status.exitstatus}:\n#{stdout}\n#{stderr}" unless [0, 3].include?(status.exitstatus)

    Scenario.by_short_id(JSON.parse(stdout).map { |result| result.values_at('test_id', 'result') })
  end

  def execute_command(suite, base_url)
    inputs = inputs_with("#{base_url}/fhir").map { |name, value| "#{name}:#{value}" }
    ['bundle', 'exec', 'ruby', File.join(__dir__, 'inferno_execute.rb'), '--suite', suite_id,
     '--short-ids', *groups_in(suite).map(&:short_id), '--inputs', *inputs, '--outputter', 'json']
  end
end
