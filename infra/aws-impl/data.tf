
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

# data "aws_secret_manager_secret" "rds" { ## if secret or db is created outside of module without state lookup available
#   filter {
#     name   = "tag:aws:secretsmanager:owningService"
#     values = ["rds"]
#   }

#   filter {
#     name   = "tag:Name"
#     values = ["inferno"]
#   }
# }

data "aws_secretsmanager_secret_version" "rds" {
  secret_id = module.rds.db_instance_master_user_secret_arn
}