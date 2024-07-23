
## EKS Cluster auth
data "aws_eks_cluster" "cluster" {
  name = var.cluster_name
}

data "aws_eks_cluster_auth" "cluster_auth" {
  name = var.cluster_name
}



data "aws_vpc" "k8s" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]

  }
}

data "aws_db_subnet_group" "k8s" {
  name = var.vpc_name
}