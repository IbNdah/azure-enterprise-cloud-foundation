##################################################
# Landing Zone - Sandbox
##################################################

terraform {
  required_version = ">= 1.10"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }

  backend "azurerm" {}
}

##################################################
# Provider
##################################################

provider "azurerm" {
  features {}

  subscription_id = var.subscription_id
}

##################################################
# Workload Resource Group
##################################################

module "workload_resource_group" {
  source = "../../modules/resource-group"

  name     = var.resource_group_name
  location = var.location

  tags = merge(
    {
      Organization = "Mandara Global"
      Project      = "Azure Enterprise Cloud Foundation"
      BusinessUnit = "OneCloud"
      Department   = "IT"
      ManagedBy    = "Terraform"
    },
    var.tags,
    {
      LandingZone = "Sandbox"
    }
  )
}
