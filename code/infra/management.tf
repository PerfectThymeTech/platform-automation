module "management" {
  source = "./modules/management"
  providers = {
    azurerm = azurerm.management
  }

  location    = var.location
  environment = var.environment
  prefix      = var.prefix
  tags        = var.tags
}
