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
  default     = "ghcr.io/hl7au/au-fhir-core-inferno:d9dfcc93e634a8fbfb2ca5acbe5b98408d60f56d"
}

variable "validator_base_path" {
  description = "Validator base path"
  default     = "/validator"
}

variable "external_validator_url" {
  description = "External validator url"
  default     = null
}
