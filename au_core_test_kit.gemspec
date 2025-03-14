# frozen_string_literal: true

require_relative 'lib/au_core_test_kit/version'

Gem::Specification.new do |spec|
  spec.name          = 'au_core_test_kit'
  spec.version       = AUCoreTestKit::VERSION
  spec.authors       = ['Ilya Beda', 'Pavel Rozhkov']
  spec.email         = ['ilya@beda.software', 'pavel.r@beda.software']
  spec.summary       = 'AU Core Inferno tests'
  spec.description   = 'AU Core Inferno tests'
  spec.homepage      = 'https://github.com/hl7au/au-fhir-core-inferno'
  spec.license       = 'Apache-2.0'
  spec.add_runtime_dependency 'inferno_core', '>= 0.6.1'
  spec.add_runtime_dependency 'smart_app_launch_test_kit', '>= 0.4.0'
  spec.add_runtime_dependency 'tls_test_kit', '~> 0.2.0'
  spec.add_development_dependency 'database_cleaner-sequel', '~> 1.8'
  spec.add_development_dependency 'factory_bot', '~> 6.1'
  spec.add_development_dependency 'rspec', '~> 3.10'
  spec.add_development_dependency 'webmock', '~> 3.11'
  spec.required_ruby_version = Gem::Requirement.new('>= 3.3.6')
  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/hl7au/au-fhir-core-inferno'
  spec.files = [
    Dir['lib/**/*.rb'],
    Dir['lib/**/*.json'],
    Dir['lib/**/*.tgz'],
    Dir['lib/**/*.yml'],
    'LICENSE'
  ].flatten

  spec.require_paths = ['lib']
end
