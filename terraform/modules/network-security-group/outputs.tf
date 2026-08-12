output "id" {
  value       = azurerm_network_security_group.this.id
  description = "Network Security Group ID."
}

output "name" {
  value       = azurerm_network_security_group.this.name
  description = "Network Security Group name."
}
