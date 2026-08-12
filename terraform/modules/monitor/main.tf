resource "azurerm_monitor_action_group" "this" {
  name                = var.name
  short_name          = var.short_name
  resource_group_name = var.resource_group_name

  tags = var.tags
}
