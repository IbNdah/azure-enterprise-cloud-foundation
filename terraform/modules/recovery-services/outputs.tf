output "id" {
  description = "Recovery Services Vault ID."
  value       = azurerm_recovery_services_vault.this.id
}

output "name" {
  description = "Recovery Services Vault name."
  value       = azurerm_recovery_services_vault.this.name
}
