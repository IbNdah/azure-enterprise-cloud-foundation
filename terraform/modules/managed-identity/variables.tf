variable "name" {
  description = "Name of the user-assigned managed identity."
  type        = string

  validation {
    condition     = trimspace(var.name) != ""
    error_message = "name must not be empty."
  }
}

variable "location" {
  description = "Azure region where the managed identity is created."
  type        = string

  validation {
    condition     = trimspace(var.location) != ""
    error_message = "location must not be empty."
  }
}

variable "resource_group_name" {
  description = "Name of the resource group where the managed identity is created."
  type        = string

  validation {
    condition     = trimspace(var.resource_group_name) != ""
    error_message = "resource_group_name must not be empty."
  }
}

variable "tags" {
  description = "Tags to apply to the managed identity."
  type        = map(string)
  default     = {}
}
