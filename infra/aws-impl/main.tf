locals {
  namespace = "inferno"
  manifests = fileset(path.module, "manifests/*.yaml")
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
