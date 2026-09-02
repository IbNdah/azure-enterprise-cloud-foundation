##################################################
# Landing Zone - Corp
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
      LandingZone = "Corp"
    }
  )
}

##################################################
# Workload Virtual Network
##################################################

module "workload_virtual_network" {
  source = "../../modules/virtual-network"

  name                = var.vnet_name
  location            = var.location
  resource_group_name = module.workload_resource_group.name
  address_space       = var.vnet_address_space
  dns_servers         = []

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
      LandingZone = "Corp"
    }
  )
}

##################################################
# Workload Subnet
##################################################

module "workload_subnet" {
  source = "../../modules/subnet"

  resource_group_name  = module.workload_resource_group.name
  virtual_network_name = module.workload_virtual_network.name

  subnets = {
    "snet-workload" = {
      address_prefixes = ["10.10.1.0/24"]
    }
  }
}

##################################################
# Workload Network Security Group
##################################################

resource "azurerm_network_security_group" "workload" {
  name                = "nsg-corp-workload-001"
  location            = var.location
  resource_group_name = module.workload_resource_group.name

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
      LandingZone = "Corp"
    }
  )
}

##################################################
# Workload Network Interface
##################################################

resource "azurerm_network_interface" "workload" {
  name                = "nic-corp-workload-001"
  location            = var.location
  resource_group_name = module.workload_resource_group.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = module.workload_subnet.subnet_ids["snet-workload"]
    private_ip_address_allocation = "Dynamic"
  }

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
      LandingZone = "Corp"
    }
  )
}

##################################################
# Network Interface Association
##################################################

resource "azurerm_network_interface_security_group_association" "workload" {
  network_interface_id      = azurerm_network_interface.workload.id
  network_security_group_id = azurerm_network_security_group.workload.id
}

##################################################
# Workload Virtual Machine
##################################################

resource "azurerm_linux_virtual_machine" "workload" {
  name                = "vm-corp-workload-001"
  resource_group_name = module.workload_resource_group.name
  location            = var.location
  size                = var.vm_size

  admin_username                  = var.admin_username
  disable_password_authentication = true

  network_interface_ids = [
    azurerm_network_interface.workload.id
  ]

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.admin_ssh_public_key
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }

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
      LandingZone = "Corp"
    }
  )
}
