# frozen_string_literal: true

require 'fhir_stub_server'
require 'yaml'

# One spec/fixtures/stub_server/<name>/scenario.yml: which groups of a suite to run, their
# inputs and the result each test should get. FHIRStubServer.load reads only its `server:` block.
class Scenario
  DIR = File.expand_path('../fixtures/stub_server', __dir__)
  FHIR_BASE_URL = 'http://fhir.stub.test/fhir'

  def self.all
    Dir[File.join(DIR, '*', 'scenario.yml')].sort.map { |path| new(path) }
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

  def group_ids
    @config.fetch('groups')
  end

  def inputs
    @config.fetch('inputs').to_h.merge('url' => FHIR_BASE_URL).transform_keys(&:to_sym)
  end

  # Test short id => pass, fail, skip, omit or error.
  def expected
    @config.fetch('expected').to_h
  end

  # A new Stub each call, so every run starts with empty reports.
  def stub
    FHIRStubServer.load(path)
  end
end
