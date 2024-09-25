resource "azurerm_resource_group" "resource_group_identity" {
  name     = "${local.prefix}-identity-rg"
  location = var.location
  tags     = var.tags
}

resource "azurerm_resource_group" "resource_group_networking" {
  name     = "${local.prefix}-networking-rg"
  location = var.location
  tags     = var.tags
}
