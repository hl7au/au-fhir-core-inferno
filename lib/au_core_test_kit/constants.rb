# frozen_string_literal: true

module Constants
  # SNOMED CT edition the validator resolves version-less http://snomed.info/sct codes
  # against.
  #
  # The validator defaults cliContext.snomedCT to the International edition
  # (900000000000207008) and turns it into the expansion parameter
  # "system-version=http://snomed.info/sct|http://snomed.info/sct/<edition>". The AU
  # terminology server carries only the Australian edition, so the default makes every
  # SNOMED lookup fail with "A definition for CodeSystem 'http://snomed.info/sct'
  # version 'null' could not be found", after which the validator reports valid codes
  # as absent from their value sets.
  #
  # The Australian edition is a derivative containing the full International release
  # plus the AU extension and AMT, so selecting it loses nothing. It is also the only
  # edition that resolves AMT codes, which carry a required binding on
  # Medication.code.coding:amt.
  def self.snomed_edition
    ENV.fetch('SNOMED_EDITION', 'au')
  end

  def self.validation_message_filters
    [
      "The value provided ('xml') was not found in the value set 'MimeType'",
      "The value provided ('json') was not found in the value set 'MimeType'",
      "The value provided ('ttl') was not found in the value set 'MimeType'"
    ].freeze
  end
end
