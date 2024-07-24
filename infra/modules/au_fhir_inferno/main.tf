locals {
  namespace              = var.namespace
  manifests              = fileset(path.module, "manifests/inferno/*.yaml")
  inferno_image          = var.inferno_image
  terminology_server     = var.terminology_server
  base_url               = var.base_url
  external_validator_url = var.external_validator_url != null ? var.external_validator_url : "${var.base_url}validatorapi"
  validator_base_path    = var.validator_base_path
}

resource "kubernetes_secret" "postgres_database" {
  metadata {
    name      = "postgres-database"
    namespace = local.namespace
  }

  data = {
    POSTGRES_DB       = "inferno"
    POSTGRES_PASSWORD = jsondecode(data.aws_secretsmanager_secret_version.rds.secret_string)["password"]
  }
}



data "aws_secretsmanager_secret" "rds" { ## if secret or db is created outside of module without state lookup available
  arn = "arn:aws:secretsmanager:ap-southeast-2:471112546300:secret:rds!db-9fc631ab-b769-40f7-8666-efefab4f45c8-BUES5u"

  # filter is not available for this datasource
}


data "aws_secretsmanager_secret_version" "rds" {
  secret_id = data.aws_secretsmanager_secret.rds.id
}


resource "kubernetes_config_map" "postgres" {
  metadata {
    name      = "postgres"
    namespace = local.namespace
  }

  data = {
    POSTGRES_HOST = "inferno-postgresql.creaskuwcgs3.ap-southeast-2.rds.amazonaws.com"
    POSTRGES_PORT = 5432
    POSTGRES_USER = "postgres"
  }
}

resource "kubernetes_config_map" "inferno" {
  metadata {
    name      = "inferno"
    namespace = local.namespace
  }

  data = {
    FHIR_RESOURCE_VALIDATOR_URL = "http://validator-api:4567"
    REDIS_URL                   = "redis://inferno-redis:6379"
    RAILS_ENV                   = "production"
  }
}



resource "kubernetes_namespace" "namespace" {
  metadata {
    name = local.namespace
  }
}

resource "kubernetes_manifest" "inferno" {
  for_each = { for m in local.manifests : m => "${path.module}/${m}" }

  manifest = yamldecode(templatefile(each.value, {
    namespace              = local.namespace
    inferno_image          = local.inferno_image
    terminology_server     = local.terminology_server
    base_url               = local.base_url
    external_validator_url = local.external_validator_url
    validator_base_path    = local.validator_base_path
  }))
  depends_on = [
    kubernetes_namespace.namespace,
    kubernetes_secret.postgres_database,
    kubernetes_config_map.postgres,
    kubernetes_config_map.inferno,
  ]
}
