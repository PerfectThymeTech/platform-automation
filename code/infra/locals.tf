locals {
  prefix = "${lower(var.prefix)}-${var.environment}"
  default_template_variables = {
    # Scope variables
    scope_id_root          = "/providers/Microsoft.Management/managementGroups/${azurerm_management_group.management_group_root.name}"
    scope_id_platform      = "/providers/Microsoft.Management/managementGroups/${azurerm_management_group.management_group_platform.name}"
    scope_id_identity      = "/providers/Microsoft.Management/managementGroups/${azurerm_management_group.management_group_identity.name}"
    scope_id_management    = "/providers/Microsoft.Management/managementGroups/${azurerm_management_group.management_group_management.name}"
    scope_id_connectivity  = "/providers/Microsoft.Management/managementGroups/${azurerm_management_group.management_group_connectivity.name}"
    scope_id_landing_zones = "/providers/Microsoft.Management/managementGroups/${azurerm_management_group.management_group_landing_zones.name}"
    scope_id_corp          = "/providers/Microsoft.Management/managementGroups/${azurerm_management_group.management_group_corp.name}"
    scope_id_cloud_native  = "/providers/Microsoft.Management/managementGroups/${azurerm_management_group.management_group_cloud_native.name}"
    scope_id_playground    = "/providers/Microsoft.Management/managementGroups/${azurerm_management_group.management_group_playground.name}"
    scope_id_decomissioned = "/providers/Microsoft.Management/managementGroups/${azurerm_management_group.management_group_decomissioned.name}"
  }

  template_variables = merge(local.default_template_variables, var.custom_template_variables)
}
