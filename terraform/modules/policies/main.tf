##################################################
# Policy Definition
##################################################
resource "azurerm_policy_definition" "this" {
  name         = var.name
  display_name = var.display_name
  description  = var.description

  policy_type = "Custom"
  mode        = "All"

  policy_rule = var.policy_rule

  parameters = var.parameters
}

##################################################
# Policy Assignment
##################################################
resource "azurerm_subscription_policy_assignment" "this" {
  name                 = var.assignment_name
  display_name         = var.assignment_display_name
  policy_definition_id = azurerm_policy_definition.this.id
  subscription_id      = var.subscription_id

  parameters = var.assignment_parameters
}
