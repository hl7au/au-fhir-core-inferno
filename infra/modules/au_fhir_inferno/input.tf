variable "namespace" {
  description = "namespace for inferno"
  default     = "inferno"
}

variable "base_url" {
  description = "Base url for the inferno server"
}

variable "terminology_server" {
  description = "Terminology server url"
  default     = "https://tx.test.hl7.org.au/fhir"
}

variable "inferno_image" {
  description = "Docker image for inferno"
  default     = "bedasoftware/au-fhir-core-inferno-inferno:9d84e44f73fedd6224c8b8f04eddd5fab3bd122a"
}

variable "validator_base_path" {
  description = "Validator base path"
  default     = "/validator"
}

variable "external_validator_url" {
  description = "External validator url"
  default     = null
}
