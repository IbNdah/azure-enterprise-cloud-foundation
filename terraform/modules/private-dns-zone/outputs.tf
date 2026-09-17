output "id" {
  description = "Resource ID of the Private DNS zone."
  value       = azurerm_private_dns_zone.this.id
}

output "name" {
  description = "Name of the Private DNS zone."
  value       = azurerm_private_dns_zone.this.name
}

output "vnet_link_id" {
  description = "Resource ID of the Private DNS zone VNet link."
  value       = azurerm_private_dns_zone_virtual_network_link.this.id
}
