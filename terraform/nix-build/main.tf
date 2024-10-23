locals {
  nix_options = jsonencode({
    options = { for k, v in var.nix_options : k => v }
  })
}
data "external" "nix-build" {
  program = [ "${path.module}/nix-build.sh" ]
  query = {
    wrapper_path = "${path.module}/wrapper.tmpl.nix"
    attribute = var.attribute
    file = var.file
    nix_options = local.nix_options
    content_file = var.content_file
    content_nar = var.content_nar
  }
}
output "result" {
  value = data.external.nix-build.result
}
