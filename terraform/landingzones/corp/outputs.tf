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
