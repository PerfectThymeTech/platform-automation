module "management" {
  source = "./modules/management"
  providers = {
    azurerm = azurerm.management
  }

  location                 = var.location
  environment              = var.environment
  prefix                   = var.prefix
  tags                     = var.tags
  management_group_root_id = azurerm_management_group.management_group_root.id
}
