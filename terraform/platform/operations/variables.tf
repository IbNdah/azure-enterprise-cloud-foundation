variable "resource_group_name" {
  description = "Operations Resource Group name."
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

variable "monitor_action_group_name" {
  description = "Operations Monitor Action Group name."
  type        = string
}

variable "monitor_action_group_short_name" {
  description = "Operations Monitor Action Group short name."
  type        = string
}
