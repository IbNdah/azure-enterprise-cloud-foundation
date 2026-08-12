variable "name" {
  description = "Recovery Services Vault name."
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

variable "sku" {
  description = "Recovery Services Vault SKU."
  type        = string
  default     = "Standard"
}

variable "soft_delete_enabled" {
  description = "Enable soft delete."
  type        = bool
  default     = true
}

variable "tags" {
  description = "Resource tags."
  type        = map(string)
  default     = {}
}
