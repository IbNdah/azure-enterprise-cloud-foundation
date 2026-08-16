##################################################
# Platform Resource Groups
##################################################

variable "management_resource_group_name" {
  description = "Management platform Resource Group name."
  type        = string
}

variable "connectivity_resource_group_name" {
  description = "Connectivity platform Resource Group name."
  type        = string
}

variable "security_resource_group_name" {
  description = "Security platform Resource Group name."
  type        = string
}

variable "operations_resource_group_name" {
  description = "Operations platform Resource Group name."
  type        = string
}

variable "identity_resource_group_name" {
  description = "Identity platform Resource Group name."
  type        = string
}

##################################################
# General
##################################################

variable "environment" {
  description = "Deployment environment."
  type        = string
}

variable "location" {
  description = "Azure deployment region."
  type        = string
}

variable "tags" {
  description = "Additional deployment tags."
  type        = map(string)
  default     = {}
}

##################################################
# Security
##################################################

variable "tenant_id" {
  description = "Microsoft Entra ID tenant ID."
  type        = string
}

variable "key_vault_name" {
  description = "Platform Key Vault name."
  type        = string
}
