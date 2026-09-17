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

variable "public_network_access_enabled" {
  description = "Allow public network access to the Key Vault."
  type        = bool
  default     = false
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

##################################################
# Virtual Network
##################################################
variable "virtual_network_id" {
  description = "Resource ID of the Hub Virtual Network used for private connectivity."
  type        = string
}

##################################################
# Log Analytics Workspace
##################################################

variable "log_analytics_workspace_id" {
  description = "Central Log Analytics Workspace resource ID used for security resource diagnostics."
  type        = string
}
