<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_external"></a> [external](#provider\_external) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [external_external.nixos-vars](https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/external) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_content"></a> [content](#input\_content) | Content to expose to the NixOS build as a file. | `string` | `"{}"` | no |
| <a name="input_filename"></a> [filename](#input\_filename) | Name of the file to which to dump `content`. Defaults to `nixos-vars.json`. | `string` | `"./nixos-vars.json"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_result"></a> [result](#output\_result) | n/a |
<!-- END_TF_DOCS -->