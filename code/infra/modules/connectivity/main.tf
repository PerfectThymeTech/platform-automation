resource "azurerm_resource_group" "resource_group_private_dns" {
  name     = "${local.prefix}-privatedns-rg"
  location = var.location
  tags     = var.tags
}

resource "azurerm_resource_group" "resource_group_hub" {
  name     = "${local.prefix}-hub-${var.location}-rg"
  location = var.location
  tags     = var.tags
}

resource "azurerm_resource_group" "resource_group_network_manager" {
  name     = "${local.prefix}-ntwrkmngr-rg"
  location = var.location
  tags     = var.tags
}
