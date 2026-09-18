output "id" {
  description = "Azure Policy definition ID."
  value       = azurerm_policy_definition.this.id
}

output "name" {
  description = "Azure Policy definition name."
  value       = azurerm_policy_definition.this.name
}
