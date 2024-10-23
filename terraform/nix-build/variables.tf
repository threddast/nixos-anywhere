variable "attribute" {
  type = string
  description = "the attribute to build, can also be a flake"
}

variable "file" {
  type = string
  description = "the nix file to evaluate, if not run in flake mode"
  default = null
}

variable "nix_options" {
  type = map(string)
  description = "the options of nix"
  default = {}
}

variable "content_file" {
  type = string
  description = "name of the file to be passed, if any"
  default = null
}

variable "content_nar" {
  type = string
  description = "nar of the content file, if applicable"
  default = null
}
