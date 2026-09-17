##################################################
# Platform Management
##################################################

module "management" {
  source = "./platform/management"

  resource_group_name = var.management_resource_group_name
  location            = var.location
  log_analytics_name  = var.log_analytics_name
  allowed_locations   = var.allowed_locations

  tags = merge(
    local.common_tags,
    var.tags,
    {
      Capability = "Management"
    }
  )
}

##################################################
# Platform Connectivity
##################################################

module "connectivity" {
  source = "./platform/connectivity"

  resource_group_name  = var.connectivity_resource_group_name
  virtual_network_name = "vnet-platform-${var.environment}-001"

  location      = var.location
  address_space = ["10.0.0.0/16"]

  subnets = {
    management = {
      address_prefixes = ["10.0.1.0/24"]
    }

    shared = {
      address_prefixes = ["10.0.2.0/24"]
    }
  }

  tags = merge(
    local.common_tags,
    var.tags,
    {
      Capability = "Connectivity"
    }
  )
}

##################################################
# Platform Security
##################################################

module "security" {
  source = "./platform/security"

  resource_group_name = var.security_resource_group_name
  location            = var.location

  tenant_id      = var.tenant_id
  key_vault_name = var.key_vault_name

  log_analytics_workspace_id = module.management.log_analytics_workspace_id

  private_endpoint_subnet_id = module.connectivity.private_endpoint_subnet_id
  virtual_network_id         = module.connectivity.virtual_network_id

  tags = merge(
    local.common_tags,
    var.tags,
    {
      Capability = "Security"
    }
  )
}

##################################################
# Platform Operations
##################################################

module "operations" {
  source = "./platform/operations"

  resource_group_name             = var.operations_resource_group_name
  location                        = var.location
  monitor_action_group_name       = var.monitor_action_group_name
  monitor_action_group_short_name = var.monitor_action_group_short_name

  tags = merge(
    local.common_tags,
    var.tags,
    {
      Capability = "Operations"
    }
  )
}

##################################################
# Platform Identity
##################################################

module "identity" {
  source = "./platform/identity"

  resource_group_name = var.identity_resource_group_name
  location            = var.location

  tags = merge(
    local.common_tags,
    var.tags,
    {
      Capability = "Identity"
    }
  )
}
