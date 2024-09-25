resource "azurerm_firewall" "firewall" {
  name                = "${local.prefix}-fw001"
  location            = var.location
  resource_group_name = azurerm_resource_group.resource_group_hub.name
  tags                = var.tags

  sku_name           = "AZFW_VNet"
  sku_tier           = "Standard"
  firewall_policy_id = azurerm_firewall_policy.firewall_policy.id
  ip_configuration {
    name                 = "public-ip"
    public_ip_address_id = azurerm_public_ip.public_ip.id
    subnet_id            = azurerm_subnet.subnet_firewall.id
  }
  zones = [
    1,
    2,
    3
  ]
}
