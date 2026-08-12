resource "azurerm_subnet" "this" {
  for_each = var.subnets

  name                 = each.key
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name

  address_prefixes = each.value.address_prefixes

  service_endpoints = lookup(each.value, "service_endpoints", [])

  private_endpoint_network_policies = lookup(
    each.value,
    "private_endpoint_network_policies",
    "Enabled"
  )

  private_link_service_network_policies_enabled = lookup(
    each.value,
    "private_link_service_network_policies_enabled",
    true
  )
}
