locals {
  namespace          = var.namespace
  manifests          = fileset(path.module, "manifests/inferno/*.yaml")
  inferno_image      = "bedasoftware/au-fhir-core-inferno-inferno:a63aeb4ba9b4a3e2024cc33a2646aac625a2894e"
  terminology_server = "https://tx.test.hl7.org.au/fhir"
  base_url           = var.base_url
}


resource "random_password" "postgres_password" {
  length  = 32
  special = false
}

resource "kubernetes_secret" "postgres_database" {
  metadata {
    name      = "postgres-database"
    namespace = local.namespace
  }

  data = {
    POSTGRES_DB       = "inferno"
    POSTGRES_PASSWORD = random_password.postgres_password.result
  }
}

resource "kubernetes_config_map" "postgres" {
  metadata {
    name      = "postgres"
    namespace = local.namespace
  }

  data = {
    POSTGRES_HOST = "inferno-postgres"
    POSTRGES_PORT = 5432
    POSTGRES_USER = "postgres"
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
    namespace          = local.namespace
    inferno_image      = local.inferno_image
    terminology_server = local.terminology_server
    base_url           = local.base_url
    postgres_password  = random_password.postgres_password.result
  }))
  depends_on = [kubernetes_namespace.namespace, kubernetes_secret.postgres_database, kubernetes_config_map.postgres]
}
