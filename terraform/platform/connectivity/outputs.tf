output "resource_group_name" {
  value = module.connectivity_resource_group.name
}

output "virtual_network_name" {
  value = module.hub_virtual_network.name
}

output "virtual_network_id" {
  value = module.hub_virtual_network.id
}

output "subnet_ids" {
  value = module.hub_subnets.subnet_ids
}

output "network_security_group_id" {
  value = module.hub_network_security_group.id
}
