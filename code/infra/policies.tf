# Top-level Management Group Policies
module "policies_root" {
  source = "./modules/policies"
  providers = {
    azurerm = azurerm
  }

  location                                 = var.location
  management_group_name                    = azurerm_management_group.management_group_root.name
  management_group_id                      = azurerm_management_group.management_group_root.id
  azure_resources_library_folder           = "root"
  custom_template_variables                = local.template_variables
  dependency_parent                        = true
  policy_definition_roles_parent           = {}
  policy_set_definition_references_parents = {}
}

module "policy_role_assignments_root" {
  source = "./modules/policy_role_assignments"
  providers = {
    azurerm = azurerm
  }

  for_each = module.policies_root.policy_assignment_references

  management_group_id            = azurerm_management_group.management_group_root.id
  policy_assignment_principal_id = each.value.principal_id
  policy_definition_id           = each.value.policy_definition_id
  policy_definition_references   = lookup(module.policies_root.policy_set_definition_references, each.value.policy_definition_id, [])
  policy_definition_roles        = module.policies_root.policy_definition_roles
}

# Landing Zone Management Groups Policies
module "policies_landing_zones" {
  source = "./modules/policies"
  providers = {
    azurerm = azurerm
  }

  location                                 = var.location
  management_group_name                    = azurerm_management_group.management_group_landing_zones.name
  management_group_id                      = azurerm_management_group.management_group_landing_zones.id
  azure_resources_library_folder           = "landing_zones"
  custom_template_variables                = local.template_variables
  dependency_parent                        = module.policies_root.policy_deployments_completed
  policy_definition_roles_parent           = module.policies_root.policy_definition_roles
  policy_set_definition_references_parents = {} # module.policies_root.policy_set_definition_references
}

module "policy_role_assignments_landing_zones" {
  source = "./modules/policy_role_assignments"
  providers = {
    azurerm = azurerm
  }

  for_each = module.policies_landing_zones.policy_assignment_references

  management_group_id            = azurerm_management_group.management_group_landing_zones.id
  policy_assignment_principal_id = each.value.principal_id
  policy_definition_id           = each.value.policy_definition_id
  policy_definition_references   = lookup(module.policies_landing_zones.policy_set_definition_references, each.value.policy_definition_id, [])
  policy_definition_roles        = module.policies_landing_zones.policy_definition_roles
}
