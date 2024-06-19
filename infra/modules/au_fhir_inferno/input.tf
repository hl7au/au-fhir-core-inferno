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
  default     = "ghcr.io/hl7au/au-fhir-core-inferno:02b9f982f5473f42f3353f6ae907da1f74b6f40c"
}

variable "validator_base_path" {
  description = "Validator base path"
  default     = "/validator"
}

variable "external_validator_url" {
  description = "External validator url"
  default     = null
}
