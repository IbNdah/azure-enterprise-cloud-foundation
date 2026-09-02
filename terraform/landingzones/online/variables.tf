##################################################
# Landing Zone - Online Variables
##################################################

variable "subscription_id" {
  description = "Azure subscription ID."
  type        = string
}

variable "resource_group_name" {
  description = "Workload Resource Group name."
  type        = string
  default     = "rg-online-workloads-001"
}

variable "location" {
  description = "Azure region."
  type        = string
  default     = "westeurope"
}

variable "tags" {
  description = "Additional resource tags."
  type        = map(string)
  default     = {}
}
