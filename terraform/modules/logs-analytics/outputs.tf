output "id" {
  description = "Log Analytics Workspace ID."
  value       = azurerm_log_analytics_workspace.this.id
}

output "name" {
  description = "Workspace name."
  value       = azurerm_log_analytics_workspace.this.name
}

output "workspace_id" {
  description = "Workspace ID."
  value       = azurerm_log_analytics_workspace.this.workspace_id
}

output "primary_shared_key" {
  description = "Primary shared key."
  value       = azurerm_log_analytics_workspace.this.primary_shared_key
  sensitive   = true
}
