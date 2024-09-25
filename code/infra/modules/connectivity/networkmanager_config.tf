# Create network group for spoke vnets
resource "azurerm_network_manager_network_group" "network_manager_network_group_spokes" {
  name               = "${local.prefix}-avnm-group-spokes"
  network_manager_id = azurerm_network_manager.network_manager.id

  description = "Network Group for spoke VNets (${local.prefix})"
}

resource "azurerm_network_manager_connectivity_configuration" "network_manager_connectivity_configuration_spokes" {
  name               = "${local.prefix}-avnm-connectivity-spokes"
  network_manager_id = azurerm_network_manager.network_manager.id

  applies_to_group {
    group_connectivity  = "DirectlyConnected"
    global_mesh_enabled = true
    network_group_id    = azurerm_network_manager_network_group.network_manager_network_group_spokes.id
    use_hub_gateway     = true
  }
  connectivity_topology           = "HubAndSpoke"
  description                     = "Hub and Spoke network configuration."
  delete_existing_peering_enabled = true
  global_mesh_enabled             = true
  hub {
    resource_id   = azurerm_virtual_network.virtual_network_hub.id
    resource_type = "Microsoft.Network/virtualNetworks"
  }
}

resource "azurerm_network_manager_static_member" "network_manager_static_members" {
  for_each = toset(var.virtual_network_spoke_ids)

  name                      = "sttc-${reverse(split("/", each.key))[0]}-${split("/", each.key)[2]}"
  network_group_id          = azurerm_network_manager_network_group.network_manager_network_group_spokes.id
  target_virtual_network_id = each.key
}

resource "azurerm_network_manager_deployment" "network_manager_mesh_deployment_connectivity" {
  network_manager_id = azurerm_network_manager.network_manager.id

  configuration_ids = [
    azurerm_network_manager_connectivity_configuration.network_manager_connectivity_configuration_spokes.id,
  ]
  location     = var.location
  scope_access = "Connectivity"
  triggers = {
    for item in var.virtual_network_spoke_ids :
    replace(item, "/", "-") => item
  }

  depends_on = [
    azurerm_network_manager_static_member.network_manager_static_members
  ]
}
