resource "azurerm_virtual_network" "virtual_network_hub" {
  count = var.vnet_spoke_details.enabled ? 1 : 0

  name                = "${var.vnet_spoke_details.name_prefix}-${local.prefix}-vnet001"
  location            = var.location
  resource_group_name = azurerm_resource_group.resource_group_networking.name
  tags                = var.tags

  address_space = var.vnet_spoke_details.address_prefixes
  # ddos_protection_plan {
  #   enable = false
  #   id     = ""
  # }
  dns_servers = var.vnet_spoke_details.dns_servers
  encryption {
    enforcement = "AllowUnencrypted"
  }
  flow_timeout_in_minutes = 4
}
