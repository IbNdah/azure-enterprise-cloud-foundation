module "management_resource_group" {

  source = "../../modules/resource-group"

  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

module "management_log_analytics" {
  source = "../../modules/logs-analytics"

  name                = var.log_analytics_name
  location            = var.location
  resource_group_name = module.management_resource_group.name

  tags = var.tags
}
