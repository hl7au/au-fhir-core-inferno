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
  default     = "ghcr.io/hl7au/au-fhir-core-inferno:f4b6ac229de95128244d121807ac6af1f0c1ea64"
}

variable "validator_base_path" {
  description = "Validator base path"
  default     = "/hl7validatorapi"
}

variable "external_validator_url" {
  description = "External validator url"
  default     = null
}
