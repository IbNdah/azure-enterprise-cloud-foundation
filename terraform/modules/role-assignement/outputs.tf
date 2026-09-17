output "role_assignment_id" {
  description = "ID of the Azure RBAC role assignment."
  value       = azurerm_role_assignment.this.id
}
