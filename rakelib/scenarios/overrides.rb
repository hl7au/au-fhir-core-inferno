# frozen_string_literal: true

require 'yaml'
require 'fhir_stub_server'

module AUCoreTestKit
  module Scenarios
    # A Scenario's hand-written `overrides.yml`, which nothing here ever writes.
    class Overrides
      class Error < StandardError; end

      FILE = 'overrides.yml'
      KEYS = %w[inputs server expected known_gaps].freeze
      RESULTS = %w[pass fail skip omit error].freeze

      attr_reader :inputs, :expected

      def self.load(dir)
        path = File.join(dir, FILE)
        new(File.exist?(path) ? YAML.safe_load_file(path) || {} : {}, path)
      end

      def initialize(yaml, path)
        unknown = (yaml.keys - KEYS).first
        raise Error, "#{path}: unknown top-level key \"#{unknown}\"" if unknown

        @inputs = yaml['inputs'] || {}
        @server = yaml['server'] || {}
        @expected = checked_expected(yaml['expected'] || {}, path)
        @gap_keys = gap_keys(yaml['known_gaps'] || [], path)
      end

      def fhir_pairs = @server.dig('fhir', 'pairs') || []
      def sources = @server.dig('fhir', 'sources') || []
      def validator_pairs = @server.dig('validator', 'pairs') || []
      def expects_fail? = @expected.value?('fail')

      # A Stub `suggested_request`; a validator one has no path and is never a gap.
      def known_gap?(suggested_request)
        suggested_request['path'] ? @gap_keys.include?(request_key(suggested_request, 'suggested request')) : false
      end

      private

      def checked_expected(expected, path)
        expected.each do |id, result|
          raise Error, "#{path}: expected \"#{id}\" is \"#{result}\", not one of #{RESULTS.join('|')}" unless
            RESULTS.include?(result)
        end
      end

      def gap_keys(gaps, path)
        gaps.each_with_index.map do |gap, index|
          where = "#{path}: known_gaps[#{index}]"
          raise Error, "#{where} needs a non-empty reason" if gap['reason'].to_s.strip.empty?

          request_key(gap['request'].to_h, where)
        end
      end

      # Normalized as the gem matches a Pair: query and form body as { name => sorted values }.
      def request_key(request, where)
        FHIRStubServer::Request.key(FHIRStubServer::Request.pair(request, where)).slice(:method, :path, :query, :form)
      end
    end
  end
end
