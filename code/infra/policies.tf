# Top-level Management Group Policies
module "policies_root" {
  source = "./modules/policies"
  providers = {
    azurerm = azurerm
  }

  location                       = var.location
  management_group_name          = local.management_group_names.root
  management_group_id            = azurerm_management_group.management_group_root.id
  user_assigned_identity_id      = module.management.user_assigned_identity_id
  azure_resources_library_folder = "root"
  custom_template_variables      = local.template_variables
  dependency_parent              = true
}

# Landing Zone Management Groups Policies
module "policies_landing_zones" {
  source = "./modules/policies"
  providers = {
    azurerm = azurerm
  }

  location                       = var.location
  management_group_name          = local.management_group_names.landing_zones
  management_group_id            = azurerm_management_group.management_group_landing_zones.id
  user_assigned_identity_id      = module.management.user_assigned_identity_id
  azure_resources_library_folder = "landing_zones"
  custom_template_variables      = local.template_variables
  dependency_parent              = module.policies_root.policy_deployments_completed
}
