variable "namespace" {
  description = "namespace for inferno"
  default     = "inferno"
}

variable "base_url" {
  description = "Base url for the inferno server"
}

variable "terminology_server" {
  description = "Terminology server url"
  default     = "https://tx.dev.hl7.org.au/fhir"
}

variable "inferno_image" {
  description = "Docker image for inferno"
  default     = "ghcr.io/hl7au/au-fhir-core-inferno:3cd2bcbfc0ce04a2d8a40b167131938d61878503"
}

variable "validator_base_path" {
  description = "Validator base path"
  default     = "/validator"
}

variable "external_validator_url" {
  description = "External validator url"
  default     = null
}
