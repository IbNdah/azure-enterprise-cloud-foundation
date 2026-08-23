variable "resource_group_name" {
  description = "Identity platform Resource Group name."
  type        = string
}

variable "location" {
  description = "Azure region."
  type        = string
}

variable "tags" {
  description = "Capability-specific tags."
  type        = map(string)
  default     = {}
}
