# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.3.6'

gemspec

group :development, :test do
  gem 'debug'
  # Switch to '~> 0.1' once 0.1.0 is on RubyGems.
  gem 'fhir_stub_server', github: 'projkov/fhir_stub_server', ref: '73bcf2b'
  gem 'puma'
end

gem 'inferno_suite_generator', github: 'hl7au/inferno_suite_generator', branch: 'main'
gem 'pg', '~> 1.5'
gem 'rubocop', '~> 1.63.2'
gem 'rubocop-erb', '~> 0.3.0'
gem 'sqlite3', '~> 1.4'
gem 'validation_test_kit', github: 'beda-software/validation-test-kit', ref: '3438159ae5860216d37c559725fbfdc316ad745c'
