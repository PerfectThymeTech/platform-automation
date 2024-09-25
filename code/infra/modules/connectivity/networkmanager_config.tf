# Create network group for spoke vnets
resource "azurerm_network_manager_network_group" "network_manager_network_group_spokes" {
  name               = "${local.prefix}-avnm-group-spokes"
  network_manager_id = azurerm_network_manager.network_manager.id

  description = "Network Group for spoke VNets (${local.prefix})"
}

resource "azurerm_network_manager_connectivity_configuration" "network_manager_connectivity_configuration_spokes" {
  name                  = "${local.prefix}-avnm-connectivity-spokes"
  network_manager_id    = azurerm_network_manager.network_manager.id
  connectivity_topology = "HubAndSpoke"

  applies_to_group {
    group_connectivity  = "None"
    global_mesh_enabled = false
    network_group_id    = azurerm_network_manager_network_group.network_manager_network_group_spokes.id
    use_hub_gateway     = true
  }

  hub {
    resource_id   = azurerm_virtual_network.virtual_network_hub.id
    resource_type = "Microsoft.Network/virtualNetworks"
  }
  delete_existing_peering_enabled = true
}

resource "azurerm_network_manager_static_member" "network_manager_static_members" {
  for_each = toset(var.virtual_network_spoke_ids)

  name                      = "static-${reverse(split("/", each.key))[0]}-${split("/", each.key)[2]}"
  network_group_id          = azurerm_network_manager_network_group.network_manager_network_group_spokes.id
  target_virtual_network_id = each.key
}

resource "azurerm_network_manager_deployment" "network_manager_mesh_deployment_connectivity" {
  network_manager_id = azurerm_network_manager.network_manager.id
  location           = var.location
  scope_access       = "Connectivity"

  configuration_ids = [
    azurerm_network_manager_connectivity_configuration.network_manager_connectivity_configuration_spokes.id,
  ]

  depends_on = [
    azurerm_network_manager_static_member.network_manager_static_members
  ]
}
