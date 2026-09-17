variable "name" {
  description = "Storage Account name."
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group name."
  type        = string
}

variable "location" {
  description = "Azure region."
  type        = string
}

variable "account_tier" {
  description = "Storage account tier."
  type        = string
  default     = "Standard"
}

variable "account_replication_type" {
  description = "Replication type."
  type        = string
  default     = "LRS"
}

variable "account_kind" {
  description = "Storage account kind."
  type        = string
  default     = "StorageV2"
}

variable "access_tier" {
  description = "Access tier."
  type        = string
  default     = "Hot"
}

variable "tags" {
  description = "Resource tags."
  type        = map(string)
  default     = {}
}

variable "public_network_access_enabled" {
  description = "Allow public network access to the Storage Account."
  type        = bool
  default     = true
}
