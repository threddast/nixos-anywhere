data "external" "nixos-vars" {
  program = [ "${path.module}/nixos-vars.sh" ]
  query = {
    content = var.content
    filename = var.filename
  }
}
output "result" {
  value = data.external.nixos-vars.result
}
