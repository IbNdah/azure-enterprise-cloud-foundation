##################################################
# Landing Zone - Corp Variables
##################################################

variable "subscription_id" {
  description = "Azure subscription ID."
  type        = string
}

variable "resource_group_name" {
  description = "Workload Resource Group name."
  type        = string
  default     = "rg-corp-workloads-001"
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

##################################################
# Workload Virtual Network Variables
##################################################

variable "vnet_name" {
  description = "Workload Virtual Network name."
  type        = string
  default     = "vnet-corp-workload-001"
}

variable "vnet_address_space" {
  description = "Workload Virtual Network address space."
  type        = list(string)
  default     = ["10.10.0.0/16"]
}

##################################################
# Workload Virtual Machine Variables
##################################################

variable "vm_size" {
  description = "Workload Virtual Machine size."
  type        = string
  default     = "Standard_B2s"
}

variable "admin_username" {
  description = "Linux VM administrator username."
  type        = string
  default     = "azureadmin"
}

variable "admin_ssh_public_key" {
  description = "SSH public key used for Linux VM authentication."
  type        = string
}
