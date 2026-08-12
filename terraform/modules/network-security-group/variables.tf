variable "name" {
  type        = string
  description = "Network Security Group name."
}

variable "resource_group_name" {
  type        = string
  description = "Resource Group name."
}

variable "location" {
  type        = string
  description = "Azure region."
}

variable "tags" {
  type        = map(string)
  description = "Resource tags."
  default     = {}
}
