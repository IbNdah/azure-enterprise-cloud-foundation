##################################################
# Landing Zone - Corp Outputs
##################################################

output "subscription_id" {
  value = var.subscription_id
}

output "resource_group_name" {
  value = module.workload_resource_group.name
}

output "resource_group_id" {
  value = module.workload_resource_group.id
}

##################################################
# Workload Virtual Network Outputs
##################################################

output "vnet_name" {
  value = module.workload_virtual_network.name
}

output "vnet_id" {
  value = module.workload_virtual_network.id
}

output "subnet_id" {
  value = module.workload_subnet.subnet_ids["snet-workload"]
}

##################################################
# Workload Virtual Machine Outputs
##################################################

output "vm_name" {
  value = azurerm_linux_virtual_machine.workload.name
}

output "vm_id" {
  value = azurerm_linux_virtual_machine.workload.id
}

output "vm_private_ip" {
  value = azurerm_network_interface.workload.private_ip_address
}
