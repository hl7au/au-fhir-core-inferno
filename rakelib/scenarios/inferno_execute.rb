# frozen_string_literal: true

# `inferno execute ARGV` in a child process. The test database is SQLite in memory, which
# nothing migrates in a fresh process, so migrate it first.
require 'inferno/config/application'
require 'inferno/utils/migration'
Inferno::Utils::Migration.new.run

require 'inferno/apps/cli'
Inferno::CLI::Main.start(['execute', *ARGV])
