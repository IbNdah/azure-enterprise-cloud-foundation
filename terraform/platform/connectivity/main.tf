##################################################
# Resource Group
##################################################

module "connectivity_resource_group" {

  source = "../../modules/resource-group"

  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

##################################################
# Hub Virtual Network
##################################################

module "hub_virtual_network" {

  source = "../../modules/virtual-network"

  name                = var.virtual_network_name
  location            = var.location
  resource_group_name = module.connectivity_resource_group.name

  address_space = var.address_space
  tags          = var.tags
}

##################################################
# Subnets
##################################################

module "hub_subnets" {

  source = "../../modules/subnet"

  resource_group_name  = module.connectivity_resource_group.name
  virtual_network_name = module.hub_virtual_network.name

  subnets = var.subnets
}

##################################################
# Network Security Group
##################################################

module "hub_network_security_group" {

  source = "../../modules/network-security-group"

  name                = "${var.virtual_network_name}-nsg"
  location            = var.location
  resource_group_name = module.connectivity_resource_group.name
  tags                = var.tags
}
