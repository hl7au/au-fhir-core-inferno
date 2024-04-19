# frozen_string_literal: true

environment ENV.fetch('APP_ENV', 'development')
port ENV.fetch('PUMA_PORT', 4567)
