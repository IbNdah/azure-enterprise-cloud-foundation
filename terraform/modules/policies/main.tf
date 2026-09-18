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


