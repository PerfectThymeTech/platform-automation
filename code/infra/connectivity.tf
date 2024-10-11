module "connectivity" {
  source = "./modules/connectivity"
  providers = {
    azurerm = azurerm.connectivity
  }

  location                       = var.location
  environment                    = var.environment
  prefix                         = var.prefix
  tags                           = var.tags
  vnet_address_range             = var.connectivity_hub.vnet_address_range
  log_analytics_workspace_id     = module.management.log_analytics_workspace_id
  virtual_network_spoke_ids      = var.connectivity_hub.virtual_network_spoke_ids
  management_group_root_id       = azurerm_management_group.management_group_root.id
  virtual_machine_admin_username = "VmMainUser"
  virtual_machine_admin_password = random_password.password_virtual_machine_admin.result
}

resource "random_password" "password_virtual_machine_admin" {
  keepers     = {}
  length      = 16
  lower       = true
  min_lower   = 0
  min_numeric = 0
  min_special = 0
  min_upper   = 0
  numeric     = true
  special     = true
  upper       = true
}
