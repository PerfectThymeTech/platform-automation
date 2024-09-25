resource "azurerm_public_ip_prefix" "public_ip_prefix" {
  name                = "${local.prefix}-ippre001"
  location            = var.location
  resource_group_name = azurerm_resource_group.resource_group_hub.name
  tags                = var.tags

  ip_version    = "IPv4"
  prefix_length = 31
  sku           = "Standard"
  zones = [
    1,
    2,
    3
  ]
}

resource "azurerm_public_ip" "public_ip" {
  name                = "${local.prefix}-pip001"
  location            = var.location
  resource_group_name = azurerm_resource_group.resource_group_hub.name
  tags                = var.tags

  allocation_method    = "Static"
  ddos_protection_mode = "Disabled"
  # ddos_protection_plan_id = ""
  # domain_name_label = ""
  idle_timeout_in_minutes = 4
  # ip_tags = {
  #   "key" = "value"
  # }
  ip_version          = "IPv4"
  public_ip_prefix_id = azurerm_public_ip_prefix.public_ip_prefix.id
  sku                 = "Standard"
  sku_tier            = "Regional"
  zones = [
    1,
    2,
    3
  ]
}
