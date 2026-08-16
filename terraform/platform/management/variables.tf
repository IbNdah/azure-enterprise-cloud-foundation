##################################################
# General
##################################################
variable "resource_group_name" {
  description = "Management Platform Resource Group name."
  type        = string
}

variable "location" {
  description = "Azure region."
  type        = string
}

variable "tags" {
  description = "Additional platform tags."
  type        = map(string)
  default     = {}
}
