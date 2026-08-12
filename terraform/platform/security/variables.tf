##################################################
# General
##################################################

variable "resource_group_name" {
  description = "Security Resource Group name."
  type        = string
}

variable "location" {
  description = "Azure region."
  type        = string
}

variable "tenant_id" {
  description = "Microsoft Entra tenant ID."
  type        = string
}

##################################################
# Key Vault
##################################################

variable "key_vault_name" {
  description = "Key Vault name."
  type        = string
}

variable "sku_name" {
  description = "Key Vault SKU."
  type        = string
  default     = "standard"
}

variable "purge_protection_enabled" {
  description = "Enable purge protection."
  type        = bool
  default     = true
}

variable "soft_delete_retention_days" {
  description = "Soft delete retention."
  type        = number
  default     = 90
}

##################################################
# Private Endpoint
##################################################

variable "private_endpoint_subnet_id" {
  description = "Private Endpoint subnet ID."
  type        = string
}

##################################################
# Tags
##################################################

variable "tags" {
  description = "Additional platform tags."
  type        = map(string)
  default     = {}
}
