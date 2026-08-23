module "operations_resource_group" {
  source = "../../modules/resource-group"

  name     = var.resource_group_name
  location = var.location

  tags = var.tags
}

module "operations_monitor" {
  source = "../../modules/monitor"

  name                = var.monitor_action_group_name
  short_name          = var.monitor_action_group_short_name
  resource_group_name = module.operations_resource_group.name

  tags = var.tags
}
