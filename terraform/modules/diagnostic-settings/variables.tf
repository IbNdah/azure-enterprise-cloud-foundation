variable "name" {
  description = "Diagnostic settings name."
  type        = string
}

variable "target_resource_id" {
  description = "Resource ID of the resource emitting diagnostics."
  type        = string
}

variable "log_analytics_workspace_id" {
  description = "Log Analytics Workspace resource ID receiving diagnostics."
  type        = string
}
