output "resource_group_name" {
  description = "Identity Resource Group name."
  value       = module.identity_resource_group.name
}

output "resource_group_id" {
  description = "Identity Resource Group ID."
  value       = module.identity_resource_group.id
}
