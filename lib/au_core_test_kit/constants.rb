# frozen_string_literal: true

module Constants
  def self.validation_message_filters
    [
      "The value provided ('xml') was not found in the value set 'MimeType'",
      "The value provided ('json') was not found in the value set 'MimeType'",
      "The value provided ('ttl') was not found in the value set 'MimeType'"
    ].freeze
  end
end
