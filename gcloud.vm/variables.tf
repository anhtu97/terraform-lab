variable "name" {
  type = string
}

variable "machine_type" {
  type = string
}

variable "zone" {
  type = string
}

variable "tags" {
  type = list(any)
}

variable "image" {
  type = string
}

variable "image_size" {
  type = number
}