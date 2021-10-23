variable "layer_directory" {
    type = string
}

variable "layer_name" {
    type = string
}

variable "compatible_runtimes"{
    type = list(string)
    default = ["nodejs14.x"]
}