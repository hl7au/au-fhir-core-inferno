
variable "region" {
  description = "Cluster region"
  default = "ap-southeast-2"
}

variable "cluster_name" {
  type = string
  default = "fhir-k8s-dev"
}
