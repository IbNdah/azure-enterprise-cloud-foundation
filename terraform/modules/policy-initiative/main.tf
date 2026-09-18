##################################################
# Policy Initiative / Policy Set Definition
##################################################

resource "azurerm_policy_set_definition" "this" {
  name         = var.name
  policy_type  = "Custom"
  display_name = var.display_name
  description  = var.description

  parameters = var.parameters

  dynamic "policy_definition_reference" {
    for_each = var.policy_definitions

    content {
      policy_definition_id = policy_definition_reference.value.policy_definition_id
      reference_id         = policy_definition_reference.key

      parameter_values = try(
        policy_definition_reference.value.parameter_values,
        null
      )
    }
  }
}

##################################################
# Subscription Policy Set Assignment
##################################################

resource "azurerm_subscription_policy_assignment" "this" {
  name                 = var.assignment_name
  display_name         = var.assignment_display_name
  description          = var.assignment_description
  subscription_id      = var.subscription_id
  policy_definition_id = azurerm_policy_set_definition.this.id

  parameters = var.assignment_parameters

  location = var.location

  identity {
    type = "SystemAssigned"
  }
}
