module "connectivity" {
  source = "./modules/connectivity"
  providers = {
    azurerm = azurerm.connectivity
  }

  location                   = var.location
  environment                = var.environment
  prefix                     = var.prefix
  tags                       = var.tags
  vnet_address_range         = var.connectivity_hub.vnet_address_range
  log_analytics_workspace_id = module.management.log_analytics_workspace_id
}
