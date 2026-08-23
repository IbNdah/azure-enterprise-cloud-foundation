data "azurerm_client_config" "current" {}

##################################################
# Management Platform
##################################################
module "management_resource_group" {

  source = "../../modules/resource-group"

  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

##################################################
# Log Analytics Workspace
##################################################
module "management_log_analytics" {
  source = "../../modules/logs-analytics"

  name                = var.log_analytics_name
  location            = var.location
  resource_group_name = module.management_resource_group.name

  tags = var.tags
}

##################################################
# Policy Definitions - Allowed Locations
##################################################
module "allowed_locations_policy" {
  source = "../../modules/policies"

  name         = "pol-allowed-locations"
  display_name = "Allowed resource locations"
  description  = "Restricts resource deployment to approved Azure regions."

  policy_rule = jsonencode({
    if = {
      allOf = [
        {
          field = "location"
          notIn = "[parameters('allowedLocations')]"
        },
        {
          field     = "location"
          notEquals = "global"
        }
      ]
    }

    then = {
      effect = "deny"
    }
  })

  parameters = jsonencode({
    allowedLocations = {
      type = "Array"

      metadata = {
        description = "Approved Azure regions."
        displayName = "Allowed locations"
      }
    }
  })

  ##################################################
  # Policy Assignments - Allowed Locations
  ##################################################
  assignment_name         = "assign-allowed-locations"
  assignment_display_name = "Allowed resource locations"

  subscription_id = "/subscriptions/${data.azurerm_client_config.current.subscription_id}"

  assignment_parameters = jsonencode({
    allowedLocations = {
      value = var.allowed_locations
    }
  })
}

##################################################
# Policy Definition - Required Tags
##################################################
module "required_tags_policy" {
  source = "../../modules/policies"

  name         = "pol-required-tags"
  display_name = "Required resource tags"
  description  = "Ensures that all resources have the required tags."

  policy_rule = jsonencode({
    if = {
      anyOf = [
        {
          field  = "tags['Project']"
          exists = "false"
        },
        {
          field  = "tags['ManagedBy']"
          exists = "false"
        }
      ]
    }

    then = {
      effect = "deny"
    }
  })

  ##################################################
  # Policy Assignment - Required Tags
  ##################################################
  assignment_name         = "assign-required-tags"
  assignment_display_name = "Required resource tags"

  subscription_id = "/subscriptions/${data.azurerm_client_config.current.subscription_id}"

  assignment_parameters = jsonencode({})
}
