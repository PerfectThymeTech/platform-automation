resource "azurerm_route_table" "route_table_default" {
  name                = "${local.prefix}-default-rt001"
  location            = var.location
  resource_group_name = azurerm_resource_group.resource_group_hub.name
  tags                = var.tags

  disable_bgp_route_propagation = false
  route {
    name                   = "default-firewall"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = azurerm_firewall.firewall.ip_configuration.private_ip_address
  }
}
