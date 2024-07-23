locals {
  name = "inferno"
  manifests = fileset(path.module, "manifests/*.yaml")
  namespace = local.name

  rds_name = "inferno-postgresql"
  region   = "ap-southeast-2"

  tags = {
    Name       = local.name
    GithubRepo = "https://github.com/hl7au/au-fhir-core-inferno"
  }
}


module "inferno" {
  # source = "./au_fhir_inferno"
  # source = "github.com/hl7au/au-fhir-core-inferno/infra/modules/au_fhir_inferno"
  source = "../modules/au_fhir_inferno"

  base_url = "https://inferno.hl7.org.au/"
}

resource "kubernetes_manifest" "ingress" {
  for_each = { for m in local.manifests : m => "${path.module}/${m}" }

  manifest = yamldecode(templatefile(each.value, {
    namespace = local.namespace

  }))

  field_manager {
    name = "ingress-${local.namespace}"
    # force_conflicts = true
  }

  depends_on = [module.inferno]
}



################################################################################
# RDS Module
################################################################################
module "rds" {
  source = "terraform-aws-modules/rds/aws"

  identifier = local.rds_name

  create_db_option_group    = false
  create_db_parameter_group = false

  # All available versions: https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/CHAP_PostgreSQL.html#PostgreSQL.Concepts
  engine         = "postgres"
  engine_version = "16"
  instance_class = "db.t4g.large"

  allocated_storage = 20

  # NOTE: Do NOT use 'user' as the value for 'username' as it throws:
  # "Error creating DB Instance: InvalidParameterValue: MasterUsername
  # user cannot be used as it is a reserved word used by the engine"
  db_name  = "inferno"
  username = "postgres"
  port     = 5432

  db_subnet_group_name   = data.aws_db_subnet_group.k8s.name
  vpc_security_group_ids = [module.security_group.security_group_id]

  maintenance_window = "Mon:00:00-Mon:03:00"
  # backup_window           = "03:00-06:00"
  # backup_retention_period = 1

  performance_insights_enabled          = true
  performance_insights_retention_period = 7

  tags = local.tags
}

################################################################################
# Supporting Resources
################################################################################


module "security_group" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 5.0"

  name        = "${local.rds_name}-security-group"
  description = "Inferno PostgreSQL security group"
  vpc_id      = data.aws_vpc.k8s.id

  # ingress
  ingress_with_cidr_blocks = [
    {
      from_port   = 5432
      to_port     = 5432
      protocol    = "tcp"
      description = "Inferno PostgreSQL access from within VPC"
      cidr_blocks = data.aws_vpc.k8s.cidr_block
    },
  ]

  tags = local.tags
}