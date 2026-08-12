##################################################
# General
##################################################

variable "environment" {
  description = "Deployment environment."
  type        = string
}

variable "location" {
  description = "Azure Deployment region."
  type        = string
}

variable "management_resource_group_name" {
  description = "Management Resource Group name."
  type        = string
}

variable "tags" {
  description = "Additional deployment tags."
  type        = map(string)
  default     = {}
}
