locals {
  nix_options = jsonencode({
    options = { for k, v in var.nix_options : k => v }
  })
  special_args = jsonencode({
    tf = { for k, v in var.special_args : k => v }
  })
}
data "external" "nix-build" {
  program = [ "${path.module}/nix-build.sh" ]
  query = {
    attribute = var.attribute
    file = var.file
    nix_options = local.nix_options
    special_args = local.special_args
  }
}
output "result" {
  value = data.external.nix-build.result
}
