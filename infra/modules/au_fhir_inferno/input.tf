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
  default     = "ghcr.io/hl7au/au-fhir-core-inferno:2576b4d90a4da9bdea7541d98f27dd45fb097524"
}

variable "validator_base_path" {
  description = "Validator base path"
  default     = "/hl7validatorapi"
}

variable "external_validator_url" {
  description = "External validator url"
  default     = null
}
