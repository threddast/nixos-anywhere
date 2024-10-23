variable "content" {
  type = string
  default = "{}"
  description = "Content to expose to the NixOS build as a file."
}

variable "filename" {
  type = string
  default = "./nixos-vars.json"
  description = "Name of the file to which to dump `content`. Defaults to `nixos-vars.json`."
}
