# Top-level Management Group
resource "azurerm_management_group" "management_group_root" {
  name             = "${local.prefix}-${lower(var.organization_name)}"
  display_name     = var.organization_name
  subscription_ids = []
}

resource "null_resource" "provider_registration_mg" {
  for_each = toset(local.resource_providers_to_register_at_mg)

  triggers = {}
  provisioner "local-exec" {
    command = "az provider register --namespace ${each.key} --management-group-id ${azurerm_management_group.management_group_root.name}"
  }
}

# Sleep to wait for Resource Provider registration to complete
resource "time_sleep" "sleep_provider_registration_mg" {
  create_duration = "30s"

  depends_on = [
    # azapi_resource_action.provider_registration_mg,
    null_resource.provider_registration_mg,
  ]
}

# Platform Management Groups
resource "azurerm_management_group" "management_group_platform" {
  parent_management_group_id = azurerm_management_group.management_group_root.id
  name                       = "${local.prefix}-platform"
  display_name               = "Platform"
  subscription_ids           = []

  depends_on = [
    time_sleep.sleep_provider_registration_mg
  ]
}

resource "azurerm_management_group" "management_group_identity" {
  parent_management_group_id = azurerm_management_group.management_group_platform.id
  name                       = "${local.prefix}-identity"
  display_name               = "Identity"
  subscription_ids           = null
  # var.identity_subscription_id == "" ? null : [
  #   var.identity_subscription_id
  # ]

  depends_on = [
    time_sleep.sleep_provider_registration_mg
  ]
}

resource "azurerm_management_group" "management_group_management" {
  parent_management_group_id = azurerm_management_group.management_group_platform.id
  name                       = "${local.prefix}-management"
  display_name               = "Management"
  subscription_ids = var.management_subscription_id == "" ? null : [
    var.management_subscription_id
  ]

  depends_on = [
    time_sleep.sleep_provider_registration_mg
  ]
}

resource "azurerm_management_group" "management_group_connectivity" {
  parent_management_group_id = azurerm_management_group.management_group_platform.id
  name                       = "${local.prefix}-connectivity"
  display_name               = "Connectivity"
  subscription_ids = var.connectivity_subscription_id == "" ? null : [
    var.connectivity_subscription_id
  ]

  depends_on = [
    time_sleep.sleep_provider_registration_mg
  ]
}

# Landing Zone Management Groups
resource "azurerm_management_group" "management_group_landing_zones" {
  parent_management_group_id = azurerm_management_group.management_group_root.id
  name                       = "${local.prefix}-landing-zones"
  display_name               = "Landing Zones"
  subscription_ids           = []

  depends_on = [
    time_sleep.sleep_provider_registration_mg
  ]
}

resource "azurerm_management_group" "management_group_corp" {
  parent_management_group_id = azurerm_management_group.management_group_landing_zones.id
  name                       = "${local.prefix}-corp"
  display_name               = "Corp"

  depends_on = [
    time_sleep.sleep_provider_registration_mg
  ]
}

resource "azurerm_management_group" "management_group_cloud_native" {
  parent_management_group_id = azurerm_management_group.management_group_landing_zones.id
  name                       = "${local.prefix}-cloud-native"
  display_name               = "Cloud Native"

  depends_on = [
    time_sleep.sleep_provider_registration_mg
  ]
}

# Playground Management Groups
resource "azurerm_management_group" "management_group_playground" {
  parent_management_group_id = azurerm_management_group.management_group_root.id
  name                       = "${local.prefix}-playground"
  display_name               = "Playground"

  depends_on = [
    time_sleep.sleep_provider_registration_mg
  ]
}

# Decomissioned Management Groups
resource "azurerm_management_group" "management_group_decomissioned" {
  parent_management_group_id = azurerm_management_group.management_group_root.id
  name                       = "${local.prefix}-decomissioned"
  display_name               = "Decomissioned"

  depends_on = [
    time_sleep.sleep_provider_registration_mg
  ]
}
