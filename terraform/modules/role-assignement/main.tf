resource "azurerm_role_assignment" "this" {
  principal_id         = var.principal_id
  role_definition_name = var.role
  scope                = var.scope
}
