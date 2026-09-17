##################################################
# Key Vault
##################################################

output "key_vault_id" {
  description = "Key Vault ID."
  value       = module.platform_key_vault.id
}

output "key_vault_name" {
  description = "Key Vault name."
  value       = module.platform_key_vault.name
}

output "key_vault_uri" {
  description = "Key Vault URI."
  value       = module.platform_key_vault.vault_uri
}

##################################################
# Private Endpoint
##################################################

output "private_endpoint_id" {
  description = "Private Endpoint ID."
  value       = module.platform_key_vault_private_endpoint.id
}

output "private_endpoint_name" {
  description = "Private Endpoint name."
  value       = module.platform_key_vault_private_endpoint.name
}

##################################################
# Managed Identity
##################################################

output "managed_identity_id" {
  description = "Managed Identity resource ID."
  value       = module.platform_security_identity.id
}

output "managed_identity_client_id" {
  description = "Managed Identity client ID."
  value       = module.platform_security_identity.client_id
}

output "managed_identity_principal_id" {
  description = "Managed Identity principal ID."
  value       = module.platform_security_identity.principal_id
}
