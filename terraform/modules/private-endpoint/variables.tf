variable "name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}

variable "subnet_id" {
  type = string
}

variable "private_service_connection_name" {
  type = string
}

variable "private_connection_resource_id" {
  type = string
}

variable "subresource_names" {
  type = list(string)
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "private_dns_zone_group_name" {
  description = "Name of the Private DNS zone group."
  type        = string
}

variable "private_dns_zone_ids" {
  description = "Resource IDs of the Private DNS zones associated with the Private Endpoint."
  type        = list(string)
}
