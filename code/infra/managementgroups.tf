# Top-level Management Group
resource "azurerm_management_group" "management_group_root" {
  name             = "${local.prefix}-${lower(var.organization_name)}"
  display_name     = var.organization_name
  subscription_ids = []
}

# Platform Management Groups
resource "azurerm_management_group" "management_group_platform" {
  parent_management_group_id = azurerm_management_group.management_group_root.id
  name                       = "${local.prefix}-platform"
  display_name               = "Platform"
  subscription_ids           = []
}

resource "azurerm_management_group" "management_group_identity" {
  parent_management_group_id = azurerm_management_group.management_group_platform.id
  name                       = "${local.prefix}-identity"
  display_name               = "Identity"
  subscription_ids           = null
  # var.identity_subscription_id == "" ? null : [
  #   var.identity_subscription_id
  # ]
}

resource "azurerm_management_group" "management_group_management" {
  parent_management_group_id = azurerm_management_group.management_group_platform.id
  name                       = "${local.prefix}-management"
  display_name               = "Management"
  subscription_ids = var.management_subscription_id == "" ? null : [
    var.management_subscription_id
  ]
}

resource "azurerm_management_group" "management_group_connectivity" {
  parent_management_group_id = azurerm_management_group.management_group_platform.id
  name                       = "${local.prefix}-connectivity"
  display_name               = "Connectivity"
  subscription_ids = var.connectivity_subscription_id == "" ? null : [
    var.connectivity_subscription_id
  ]
}

# Landing Zone Management Groups
resource "azurerm_management_group" "management_group_landing_zones" {
  parent_management_group_id = azurerm_management_group.management_group_root.id
  name                       = "${local.prefix}-landing-zones"
  display_name               = "Landing Zones"
  subscription_ids           = []
}

resource "azurerm_management_group" "management_group_corp" {
  parent_management_group_id = azurerm_management_group.management_group_landing_zones.id
  name                       = "${local.prefix}-corp"
  display_name               = "Corp"
}

resource "azurerm_management_group" "management_group_cloud_native" {
  parent_management_group_id = azurerm_management_group.management_group_landing_zones.id
  name                       = "${local.prefix}-cloud-native"
  display_name               = "Cloud Native"
}

# Playground Management Groups
resource "azurerm_management_group" "management_group_playground" {
  parent_management_group_id = azurerm_management_group.management_group_root.id
  name                       = "${local.prefix}-playground"
  display_name               = "Playground"
}

# Decomissioned Management Groups
resource "azurerm_management_group" "management_group_decomissioned" {
  parent_management_group_id = azurerm_management_group.management_group_root.id
  name                       = "${local.prefix}-decomissioned"
  display_name               = "Decomissioned"
}
