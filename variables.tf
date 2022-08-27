variable "layer_directory" {
  type = string
}

variable "layer_name" {
  type = string
}

variable "compatible_runtimes" {
  type    = list(string)
  default = ["nodejs16.x"]
}

variable "skip_destroy" {
  type    = bool
  default = false
}

variable "bucket" {
  type    = string
  default = null
}

variable "key" {
  type    = string
  default = null
}
