# frozen_string_literal: true

require_relative 'au_core_test_kit/custom_suites/validation_suite'

require_relative 'au_core_test_kit/generated/v1.0.0/au_core_test_suite'

require_relative 'au_core_test_kit/generated/v2.0.0/au_core_test_suite'

require_relative 'au_core_test_kit/generated/v2.1.0-draft/au_core_test_suite'

require_relative 'au_core_test_kit/generated/v3.0.0-ballot1/au_core_test_suite'

# The ci-build suite tracks the AU Core CI build on build.fhir.org and is regenerated as the
# CI build changes, so only environments that opt in with INFERNO_CI_BUILD_SUITES=true load it.
require_relative 'au_core_test_kit/generated/ci-build/au_core_test_suite' if ENV['INFERNO_CI_BUILD_SUITES'] == 'true'
