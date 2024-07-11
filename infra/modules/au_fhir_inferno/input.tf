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
  default     = "ghcr.io/hl7au/au-fhir-core-inferno:64ca82b73d26ab1c2187116d6b2800235bb30ccd"
}

variable "validator_base_path" {
  description = "Validator base path"
  default     = "/hl7validatorapi"
}

variable "external_validator_url" {
  description = "External validator url"
  default     = null
}
