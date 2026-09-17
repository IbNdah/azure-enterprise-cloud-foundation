resource "azurerm_storage_account" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location

  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type

  account_kind = var.account_kind
  access_tier  = var.access_tier

  public_network_access_enabled = var.public_network_access_enabled

  network_rules {
    default_action = "Deny"
    bypass         = ["AzureServices"]
  }

  https_traffic_only_enabled = true
  min_tls_version            = "TLS1_2"

  tags = var.tags
}
