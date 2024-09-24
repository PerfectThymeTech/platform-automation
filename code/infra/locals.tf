locals {
  prefix = "${lower(var.prefix)}-${var.environment}"

  # Resource providers to register
  resource_providers_to_register = [
    "Microsoft.Authorization",
    "Microsoft.EventGrid",
    "Microsoft.Insights",
    "Microsoft.KeyVault",
    "Microsoft.Management",
    "Microsoft.Network",
    "Microsoft.OperationsManagement",
    "Microsoft.OperationalInsights",
    "Microsoft.Resources",
    "Microsoft.Storage",
    "Microsoft.Security",
    "Microsoft.SecurityInsights",
  ]

  # Scope template variables
  scope_template_variables = {
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
  # DNS template variables
  dns_template_variables = {
    for key, value in module.connectivity.private_dns_zone_ids :
    "private_dns_zone_id_${replace(key, ".", "_")}" => value
  }
  # Management variables
  management_template_variables = {
    log_analytics_workspace_id = module.management.log_analytics_workspace_id
  }
  # Merge variables
  template_variables = merge(
    local.scope_template_variables,
    local.dns_template_variables,
    local.management_template_variables,
    var.custom_template_variables,
  )
}
