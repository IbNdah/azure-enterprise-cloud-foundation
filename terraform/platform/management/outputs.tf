output "log_analytics_workspace_id" {
  description = "Central Log Analytics Workspace resource ID."
  value       = module.management_log_analytics.id
}

output "log_analytics_workspace_name" {
  description = "Central Log Analytics Workspace name."
  value       = module.management_log_analytics.name
}

output "log_analytics_workspace_workspace_id" {
  description = "Central Log Analytics Workspace ID."
  value       = module.management_log_analytics.workspace_id
}
