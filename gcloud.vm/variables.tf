variable "project_name" {
  type = string
}

variable "region" {
  type = string
}

variable "zone" {
  type = string
}

variable "network_name" {
  type = string
}

variable "firewall_rule_name" {
  type = string
}

variable "firewall_protocol" {
  type = string
}

variable "firewall_ports" {
  type = list(any)
}

variable "firewall_source_ranges" {
  type = list(any)
}

variable "name" {
  type = string
}

variable "machine_type" {
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