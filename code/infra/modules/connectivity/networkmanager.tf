resource "azurerm_network_manager" "network_manager" {
  name = "${local.prefix}-avnm"
  resource_group_name = azurerm_resource_group.resource_group_network_manager.name
  location = var.location
  tags = var.tags

  description = "Global Virtual Network Manager for platform."
  scope {
    management_group_ids = [
        var.management_group_root_id
    ]
    subscription_ids = []
  }
  scope_accesses = [
    "Connectivity",
    "SecurityAdmin",
  ]
}
