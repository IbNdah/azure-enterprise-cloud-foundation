output "resource_group_name" {
  description = "Operations Resource Group name."
  value       = module.operations_resource_group.name
}

output "resource_group_id" {
  description = "Operations Resource Group ID."
  value       = module.operations_resource_group.id
}
