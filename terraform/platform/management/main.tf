data "azurerm_client_config" "current" {}

##################################################
# Management Platform - Resource Group
##################################################

module "management_resource_group" {
  source = "../../modules/resource-group"

  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

##################################################
# Management Platform - Log Analytics Workspace
##################################################

module "management_log_analytics" {
  source = "../../modules/logs-analytics"

  name                = var.log_analytics_name
  location            = var.location
  resource_group_name = module.management_resource_group.name

  tags = var.tags
}

##################################################
# Policy Definition - Allowed Locations
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
}

##################################################
# Policy Definition - Required Tags
##################################################

module "required_tags_policy" {
  source = "../../modules/policies"

  name         = "pol-required-tags"
  display_name = "Required resource tags"
  description  = "Ensures that all resources have the required governance tags."

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

  parameters = jsonencode({})
}

##################################################
# Security & Governance Policy Initiative
##################################################

module "security_governance_baseline" {
  source = "../../modules/policy-initiative"

  name         = "initiative-security-governance"
  display_name = "Security & Governance Baseline"
  description  = "Enterprise security and governance baseline for the Azure foundation."

  subscription_id = "/subscriptions/${data.azurerm_client_config.current.subscription_id}"
  location        = var.location

  parameters = jsonencode({
    allowedLocations = {
      type = "Array"

      metadata = {
        displayName = "Allowed locations"
      }
    }

    logAnalyticsWorkspace = {
      type = "String"

      metadata = {
        displayName = "Log Analytics workspace"
      }
    }
  })

  policy_definitions = {
    allowed_locations = {
      policy_definition_id = module.allowed_locations_policy.id

      parameter_values = jsonencode({
        allowedLocations = {
          value = "[parameters('allowedLocations')]"
        }
      })
    }

    required_tags = {
      policy_definition_id = module.required_tags_policy.id
    }

    key_vault_diagnostics = {
      policy_definition_id = "/providers/Microsoft.Authorization/policyDefinitions/bef3f64c-5290-43b7-85b0-9b254eef4c47"

      parameter_values = jsonencode({
        logAnalytics = {
          value = "[parameters('logAnalyticsWorkspace')]"
        }
      })
    }
  }

  assignment_name         = "assign-security-governance"
  assignment_display_name = "Security & Governance Baseline"
  assignment_description  = "Assigns the enterprise security and governance baseline."

  assignment_parameters = jsonencode({
    allowedLocations = {
      value = var.allowed_locations
    }

    logAnalyticsWorkspace = {
      value = module.management_log_analytics.id
    }
  })
}
