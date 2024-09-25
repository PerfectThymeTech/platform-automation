resource "azurerm_firewall_policy" "firewall_policy" {
  name                = "${local.prefix}-fw001"
  location            = var.location
  resource_group_name = azurerm_resource_group.resource_group_hub.name
  tags                = var.tags

  auto_learn_private_ranges_enabled = true
  dns {
    proxy_enabled = true
    servers = [

    ]
  }
  insights {
    enabled                            = true
    default_log_analytics_workspace_id = var.log_analytics_workspace_id
    retention_in_days                  = 30
  }
  intrusion_detection {
    mode           = "Alert"
    private_ranges = []
  }
  sku                  = "Standard"
  private_ip_ranges    = null
  sql_redirect_allowed = false
  threat_intelligence_allowlist {
    fqdns        = []
    ip_addresses = []
  }
  threat_intelligence_mode = "Alert"
}
