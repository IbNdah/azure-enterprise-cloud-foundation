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

output "security_governance_baseline_principal_id" {
  description = "Principal ID of the SystemAssigned Managed Identity used by the Security & Governance Baseline policy assignment."
  value       = module.security_governance_baseline.assignment_principal_id
}

