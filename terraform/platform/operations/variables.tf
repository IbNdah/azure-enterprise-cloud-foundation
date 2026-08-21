variable "resource_group_name" {
  description = "Operations Resource Group name."
  type        = string
}

variable "location" {
  description = "Azure region."
  type        = string
}

variable "common_tags" {
  description = "Centralized enterprise metadata."
  type        = map(string)
}

variable "tags" {
  description = "Capability-specific tags."
  type        = map(string)
  default     = {}
}
