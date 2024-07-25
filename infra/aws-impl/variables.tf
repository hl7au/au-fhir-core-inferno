
variable "region" {
  description = "Cluster region"
  default     = "ap-southeast-2"
}

variable "cluster_name" {
  type    = string
  default = "fhir-k8s-dev"
}
variable "vpc_name" {
  description = "Name of the VPC"
  type        = string
  default     = "fhir-k8s-dev-vpc"
}