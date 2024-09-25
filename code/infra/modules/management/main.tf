resource "azurerm_resource_group" "resource_group_logging" {
  name     = "${local.prefix}-logging-rg"
  location = var.location
  tags     = var.tags
}

resource "azurerm_resource_group" "resource_group_identity" {
  name     = "${local.prefix}-identity-rg"
  location = var.location
  tags     = var.tags
}
