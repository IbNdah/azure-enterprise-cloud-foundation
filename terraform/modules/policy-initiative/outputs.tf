output "id" {
  description = "Resource ID of the Policy Initiative."
  value       = azurerm_policy_set_definition.this.id
}

output "assignment_id" {
  description = "Resource ID of the subscription policy assignment."
  value       = azurerm_subscription_policy_assignment.this.id
}

output "assignment_principal_id" {
  description = "Principal ID of the SystemAssigned Managed Identity used by the policy assignment."
  value       = azurerm_subscription_policy_assignment.this.identity[0].principal_id
}
