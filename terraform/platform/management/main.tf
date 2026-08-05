module "resource_group" {

  source = "../../modules/resource_group"
  name = "rg-platform-${var.environment}-001"

  location = var.location
  tags = var.tags

}
