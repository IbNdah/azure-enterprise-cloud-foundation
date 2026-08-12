variable "resource_group_name" {
  description = "Resource Group containing the Virtual Network."
  type        = string
}

variable "virtual_network_name" {
  description = "Target Virtual Network."
  type        = string
}

variable "subnets" {
  description = "Map of subnets."

  type = map(object({
    address_prefixes = list(string)

    service_endpoints = optional(list(string), [])

    private_endpoint_network_policies = optional(string, "Enabled")

    private_link_service_network_policies_enabled = optional(bool, true)
  }))
}
