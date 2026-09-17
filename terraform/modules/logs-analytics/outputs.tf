output "id" {
  description = "Log Analytics Workspace resource ID."
  value       = azurerm_log_analytics_workspace.this.id
}

output "name" {
  description = "Log Analytics Workspace name."
  value       = azurerm_log_analytics_workspace.this.name
}

output "workspace_id" {
  description = "Log Analytics Workspace ID."
  value       = azurerm_log_analytics_workspace.this.workspace_id
}
