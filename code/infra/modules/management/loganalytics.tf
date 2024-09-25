resource "azurerm_log_analytics_workspace" "log_analytics_workspace" {
  name                = "${local.prefix}-log001"
  location            = var.location
  resource_group_name = azurerm_resource_group.resource_group_logging.name
  tags                = var.tags

  allow_resource_only_permissions         = true
  cmk_for_query_forced                    = false
  daily_quota_gb                          = -1
  immediate_data_purge_on_30_days_enabled = false
  internet_ingestion_enabled              = true
  internet_query_enabled                  = true
  local_authentication_disabled           = true
  retention_in_days                       = 30
  reservation_capacity_in_gb_per_day      = null
  sku                                     = "PerGB2018"
}
