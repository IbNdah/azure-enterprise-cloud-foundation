module "management_resource_group" {

  source = "../../modules/resource-group"

  name     = var.resource_group_name
  location = var.location

  tags = merge(
    local.common_tags,
    var.tags,
    {
      Capability = "Management"
    }
  )
}
