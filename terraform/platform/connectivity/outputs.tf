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

output "private_endpoint_subnet_id" {
  description = "Subnet ID used for Private Endpoints."

  value = module.hub_subnets.subnet_ids["shared"]
}

output "network_security_group_id" {
  value = module.hub_network_security_group.id
}
