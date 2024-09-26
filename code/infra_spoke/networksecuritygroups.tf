resource "azurerm_network_security_group" "network_security_group_default" {
  name                = "${local.prefix}-default-nsg001"
  location            = var.location
  resource_group_name = azurerm_resource_group.resource_group_networking.name
  tags                = var.tags

  security_rule = []
}
