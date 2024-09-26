resource "azurerm_virtual_network" "virtual_network_hub" {
  name                = "${local.prefix}-vnet001"
  location            = var.location
  resource_group_name = azurerm_resource_group.resource_group_hub.name
  tags                = var.tags

  address_space = [
    var.vnet_address_range
  ]
  # ddos_protection_plan {
  #   enable = false
  #   id     = ""
  # }
  dns_servers = []
  encryption {
    enforcement = "AllowUnencrypted"
  }
  flow_timeout_in_minutes = 4
}

resource "azurerm_subnet" "subnet_firewall" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = azurerm_resource_group.resource_group_hub.name
  virtual_network_name = azurerm_virtual_network.virtual_network_hub.name

  address_prefixes = [
    tostring(cidrsubnet(var.vnet_address_range, 26 - tonumber(reverse(split("/", var.vnet_address_range))[0]), 1))
  ]
  private_endpoint_network_policies             = "Enabled"
  private_link_service_network_policies_enabled = true
  service_endpoint_policy_ids                   = []
  service_endpoints                             = []
}

resource "azurerm_subnet" "subnet_bastion" {
  name                 = "AzureBastionSubnet"
  resource_group_name  = azurerm_resource_group.resource_group_hub.name
  virtual_network_name = azurerm_virtual_network.virtual_network_hub.name

  address_prefixes = [
    tostring(cidrsubnet(var.vnet_address_range, 26 - tonumber(reverse(split("/", var.vnet_address_range))[0]), 2))
  ]
  private_endpoint_network_policies             = "Enabled"
  private_link_service_network_policies_enabled = true
  service_endpoint_policy_ids                   = []
  service_endpoints                             = []
}

resource "azurerm_subnet_network_security_group_association" "subnet_bastion_network_security_group_association" {
  network_security_group_id = azurerm_network_security_group.network_security_group_bastion.id
  subnet_id                 = azurerm_subnet.subnet_bastion.id
}

resource "azurerm_subnet" "subnet_dns_inbound" {
  name                 = "AzurePrivateDnsResolverInboundSubnet"
  resource_group_name  = azurerm_resource_group.resource_group_hub.name
  virtual_network_name = azurerm_virtual_network.virtual_network_hub.name

  address_prefixes = [
    tostring(cidrsubnet(var.vnet_address_range, 26 - tonumber(reverse(split("/", var.vnet_address_range))[0]), 3))
  ]
  private_endpoint_network_policies             = "Enabled"
  private_link_service_network_policies_enabled = true
  service_endpoint_policy_ids                   = []
  service_endpoints                             = []
}

resource "azurerm_subnet_network_security_group_association" "subnet_dns_inbound_network_security_group_association" {
  network_security_group_id = azurerm_network_security_group.network_security_group_default.id
  subnet_id                 = azurerm_subnet.subnet_dns_inbound.id
}

resource "azurerm_subnet_route_table_association" "subnet_dns_inbound_route_table_association" {
  route_table_id = azurerm_route_table.route_table_default.id
  subnet_id      = azurerm_subnet.subnet_dns_inbound.id
}

resource "azurerm_subnet" "subnet_dns_outbound" {
  name                 = "AzurePrivateDnsResolverOutboundSubnet"
  resource_group_name  = azurerm_resource_group.resource_group_hub.name
  virtual_network_name = azurerm_virtual_network.virtual_network_hub.name

  address_prefixes = [
    tostring(cidrsubnet(var.vnet_address_range, 26 - tonumber(reverse(split("/", var.vnet_address_range))[0]), 4))
  ]
  private_endpoint_network_policies             = "Enabled"
  private_link_service_network_policies_enabled = true
  service_endpoint_policy_ids                   = []
  service_endpoints                             = []
}

resource "azurerm_subnet_network_security_group_association" "subnet_dns_outbound_network_security_group_association" {
  network_security_group_id = azurerm_network_security_group.network_security_group_default.id
  subnet_id                 = azurerm_subnet.subnet_dns_outbound.id
}

resource "azurerm_subnet_route_table_association" "subnet_dns_outbound_route_table_association" {
  route_table_id = azurerm_route_table.route_table_default.id
  subnet_id      = azurerm_subnet.subnet_dns_outbound.id
}

resource "azurerm_subnet" "subnet_jumpbox" {
  name                 = "JumpboxSubnet"
  resource_group_name  = azurerm_resource_group.resource_group_hub.name
  virtual_network_name = azurerm_virtual_network.virtual_network_hub.name

  address_prefixes = [
    tostring(cidrsubnet(var.vnet_address_range, 26 - tonumber(reverse(split("/", var.vnet_address_range))[0]), 5))
  ]
  private_endpoint_network_policies             = "Enabled"
  private_link_service_network_policies_enabled = true
  service_endpoint_policy_ids                   = []
  service_endpoints                             = []
}

resource "azurerm_subnet_network_security_group_association" "subnet_jumpbox_network_security_group_association" {
  network_security_group_id = azurerm_network_security_group.network_security_group_default.id
  subnet_id                 = azurerm_subnet.subnet_jumpbox.id
}

resource "azurerm_subnet_route_table_association" "subnet_jumpbox_route_table_association" {
  route_table_id = azurerm_route_table.route_table_default.id
  subnet_id      = azurerm_subnet.subnet_jumpbox.id
}

resource "azurerm_subnet" "subnet_services" {
  name                 = "ServicesSubnet"
  resource_group_name  = azurerm_resource_group.resource_group_hub.name
  virtual_network_name = azurerm_virtual_network.virtual_network_hub.name

  address_prefixes = [
    tostring(cidrsubnet(var.vnet_address_range, 26 - tonumber(reverse(split("/", var.vnet_address_range))[0]), 6))
  ]
  private_endpoint_network_policies             = "Enabled"
  private_link_service_network_policies_enabled = true
  service_endpoint_policy_ids                   = []
  service_endpoints                             = []
}

resource "azurerm_subnet_network_security_group_association" "subnet_services_network_security_group_association" {
  network_security_group_id = azurerm_network_security_group.network_security_group_default.id
  subnet_id                 = azurerm_subnet.subnet_services.id
}

resource "azurerm_subnet_route_table_association" "subnet_services_route_table_association" {
  route_table_id = azurerm_route_table.route_table_default.id
  subnet_id      = azurerm_subnet.subnet_services.id
}
