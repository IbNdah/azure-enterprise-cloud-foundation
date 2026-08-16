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

  purge_protection_enabled   = var.purge_protection_enabled
  soft_delete_retention_days = var.soft_delete_retention_days

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

  tags = var.tags
}
