variable "layer_directory" {
  type = string
}

variable "layer_name" {
  type = string
}

variable "compatible_runtimes" {
  type    = list(string)
  default = ["nodejs14.x"]
}

variable "skip_destroy" {
  type    = bool
  default = false
}

variable "package_directory" {
  type = string
}
