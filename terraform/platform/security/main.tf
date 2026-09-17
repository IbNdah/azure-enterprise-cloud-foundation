##################################################
# Security Resource Group
##################################################

module "security_resource_group" {
  source = "../../modules/resource-group"

  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

##################################################
# Platform Security - Key Vault
##################################################

module "platform_key_vault" {
  source = "../../modules/key-vault"

  name                = var.key_vault_name
  resource_group_name = module.security_resource_group.name
  location            = var.location

  tenant_id = var.tenant_id
  sku_name  = var.sku_name

  purge_protection_enabled      = var.purge_protection_enabled
  soft_delete_retention_days    = var.soft_delete_retention_days

  public_network_access_enabled = var.public_network_access_enabled

  tags = var.tags
}

##################################################
# Key Vault Private DNS
##################################################

module "platform_key_vault_private_dns" {
  source = "../../modules/private-dns-zone"

  name                = "privatelink.vaultcore.azure.net"
  resource_group_name = module.security_resource_group.name

  vnet_link_name     = "${var.key_vault_name}-dns-link"
  virtual_network_id = var.virtual_network_id

  tags = var.tags
}

##################################################
# Key Vault Private Endpoint
##################################################

module "platform_key_vault_private_endpoint" {
  source = "../../modules/private-endpoint"

  name                = "${var.key_vault_name}-pep"
  location            = var.location
  resource_group_name = module.security_resource_group.name

  subnet_id = var.private_endpoint_subnet_id

  private_service_connection_name = "${var.key_vault_name}-psc"

  private_connection_resource_id = module.platform_key_vault.id

  subresource_names = [
    "vault"
  ]

  private_dns_zone_group_name = "${var.key_vault_name}-dns-zone-group"
  private_dns_zone_ids        = [module.platform_key_vault_private_dns.id]

  tags = var.tags
}

##################################################
# Platform Security - Managed Identity
##################################################

module "platform_security_identity" {
  source = "../../modules/managed-identity"

  name                = "${var.key_vault_name}-identity"
  location            = var.location
  resource_group_name = module.security_resource_group.name

  tags = var.tags
}

##################################################
# Key Vault - Managed Identity Authorization
##################################################

module "platform_key_vault_identity_role" {
  source = "../../modules/role-assignement"

  principal_id = module.platform_security_identity.principal_id
  role         = "Key Vault Secrets User"
  scope        = module.platform_key_vault.id
}

##################################################
# Key Vault Diagnostic Settings
##################################################

module "platform_key_vault_diagnostics" {
  source = "../../modules/diagnostic-settings"

  name                       = "${var.key_vault_name}-diagnostics"
  target_resource_id         = module.platform_key_vault.id
  log_analytics_workspace_id = var.log_analytics_workspace_id
}

##################################################
# Defender for Cloud - Foundational CSPM
##################################################

resource "azurerm_security_center_subscription_pricing" "defender_cspm" {
  tier          = "Free"
  resource_type = "CloudPosture"
}
