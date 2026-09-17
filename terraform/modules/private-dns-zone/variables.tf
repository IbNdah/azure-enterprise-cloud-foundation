variable "name" {
  description = "Name of the Private DNS zone."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group containing the Private DNS zone."
  type        = string
}

variable "vnet_link_name" {
  description = "Name of the Private DNS zone VNet link."
  type        = string
}

variable "virtual_network_id" {
  description = "Resource ID of the VNet linked to the Private DNS zone."
  type        = string
}

variable "tags" {
  description = "Additional tags."
  type        = map(string)
  default     = {}
}
