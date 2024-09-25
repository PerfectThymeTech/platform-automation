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

  # Resource providers to register at management group scope
  resource_providers_to_register_at_mg = [
    "Microsoft.PolicyInsights",
    "Microsoft.Security",
    "Microsoft.SecurityInsights",
    "Microsoft.Insights",
    "Microsoft.Network",
    "Microsoft.Consumption",
  ]

  # Management Group names
  management_group_names = {
    root          = "${local.prefix}-${lower(var.organization_name)}"
    platform      = "${local.prefix}-platform"
    identity      = "${local.prefix}-identity"
    management    = "${local.prefix}-management"
    connectivity  = "${local.prefix}-connectivity"
    landing_zones = "${local.prefix}-landing-zones"
    corp          = "${local.prefix}-corp"
    cloud_native  = "${local.prefix}-cloud-native"
    playground    = "${local.prefix}-playground"
    decomissioned = "${local.prefix}-decomissioned"
  }

  # Scope template variables
  scope_template_variables = {
    scope_id_root          = "/providers/Microsoft.Management/managementGroups/${local.management_group_names.root}"
    scope_id_platform      = "/providers/Microsoft.Management/managementGroups/${local.management_group_names.platform}"
    scope_id_identity      = "/providers/Microsoft.Management/managementGroups/${local.management_group_names.identity}"
    scope_id_management    = "/providers/Microsoft.Management/managementGroups/${local.management_group_names.management}"
    scope_id_connectivity  = "/providers/Microsoft.Management/managementGroups/${local.management_group_names.connectivity}"
    scope_id_landing_zones = "/providers/Microsoft.Management/managementGroups/${local.management_group_names.landing_zones}"
    scope_id_corp          = "/providers/Microsoft.Management/managementGroups/${local.management_group_names.corp}"
    scope_id_cloud_native  = "/providers/Microsoft.Management/managementGroups/${local.management_group_names.cloud_native}"
    scope_id_playground    = "/providers/Microsoft.Management/managementGroups/${local.management_group_names.playground}"
    scope_id_decomissioned = "/providers/Microsoft.Management/managementGroups/${local.management_group_names.decomissioned}"
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
