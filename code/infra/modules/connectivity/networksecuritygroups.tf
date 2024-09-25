resource "azurerm_network_security_group" "network_security_group_default" {
  name                = "${local.prefix}-default-nsg001"
  location            = var.location
  resource_group_name = azurerm_resource_group.resource_group_hub.name
  tags                = var.tags

  security_rule = []
}

resource "azurerm_network_security_group" "network_security_group_bastion" {
  name                = "${local.prefix}-bastion-nsg001"
  location            = var.location
  resource_group_name = azurerm_resource_group.resource_group_hub.name
  tags                = var.tags

  security_rule {
    name                                       = "AllowHttpsInbound"
    description                                = "Required for HTTPS inbound communication of connecting user."
    priority                                   = 120
    direction                                  = "Inbound"
    access                                     = "Allow"
    protocol                                   = "Tcp"
    source_port_range                          = "*"
    destination_port_range                     = "443"
    source_address_prefix                      = "Internet"
    destination_address_prefix                 = "*"
    source_port_ranges                         = []
    destination_port_ranges                    = []
    source_address_prefixes                    = []
    destination_address_prefixes               = []
    source_application_security_group_ids      = []
    destination_application_security_group_ids = []
  }
  security_rule {
    name                                       = "AllowGatewayManagerInbound"
    description                                = "Required for the control plane, that is, Gateway Manager to be able to talk to Azure Bastion."
    priority                                   = 130
    direction                                  = "Inbound"
    access                                     = "Allow"
    protocol                                   = "Tcp"
    source_port_range                          = "*"
    destination_port_range                     = "443"
    source_address_prefix                      = "GatewayManager"
    destination_address_prefix                 = "*"
    source_port_ranges                         = []
    destination_port_ranges                    = []
    source_address_prefixes                    = []
    destination_address_prefixes               = []
    source_application_security_group_ids      = []
    destination_application_security_group_ids = []
  }
  security_rule {
    name                                       = "AllowAzureLoadBalancerInbound"
    description                                = "Required for the control plane, that is, Gateway Manager to be able to talk to Azure Bastion."
    priority                                   = 140
    direction                                  = "Inbound"
    access                                     = "Allow"
    protocol                                   = "Tcp"
    source_port_range                          = "*"
    destination_port_range                     = "443"
    source_address_prefix                      = "AzureLoadBalancer"
    destination_address_prefix                 = "*"
    source_port_ranges                         = []
    destination_port_ranges                    = []
    source_address_prefixes                    = []
    destination_address_prefixes               = []
    source_application_security_group_ids      = []
    destination_application_security_group_ids = []
  }
  security_rule {
    name                       = "AllowBastionCommunicationInbound"
    description                = "Required for data plane communication between the underlying components of Azure Bastion."
    priority                   = 150
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = ""
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "VirtualNetwork"
    source_port_ranges         = []
    destination_port_ranges = [
      "5701",
      "8080"
    ]
    source_address_prefixes                    = []
    destination_address_prefixes               = []
    source_application_security_group_ids      = []
    destination_application_security_group_ids = []
  }
  security_rule {
    name                       = "AllowSshRdpOutbound"
    description                = "Required for SSH and RDP outbound connectivity."
    priority                   = 100
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = ""
    source_address_prefix      = "*"
    destination_address_prefix = "VirtualNetwork"
    source_port_ranges         = []
    destination_port_ranges = [
      "22",
      "3389"
    ]
    source_address_prefixes                    = []
    destination_address_prefixes               = []
    source_application_security_group_ids      = []
    destination_application_security_group_ids = []
  }
  security_rule {
    name                                       = "AllowAzureCloudOutbound"
    description                                = "Required for Azure Cloud outbound connectivity (Logs and Metrics)."
    priority                                   = 110
    direction                                  = "Outbound"
    access                                     = "Allow"
    protocol                                   = "Tcp"
    source_port_range                          = "*"
    destination_port_range                     = "443"
    source_address_prefix                      = "*"
    destination_address_prefix                 = "AzureCloud"
    source_port_ranges                         = []
    destination_port_ranges                    = []
    source_address_prefixes                    = []
    destination_address_prefixes               = []
    source_application_security_group_ids      = []
    destination_application_security_group_ids = []
  }
  security_rule {
    name                       = "AllowBastionCommunicationOutbound"
    description                = "Required for data plane communication between the underlying components of Azure Bastion."
    priority                   = 120
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = ""
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "VirtualNetwork"
    source_port_ranges         = []
    destination_port_ranges = [
      "5701",
      "8080"
    ]
    source_address_prefixes                    = []
    destination_address_prefixes               = []
    source_application_security_group_ids      = []
    destination_application_security_group_ids = []
  }
  security_rule {
    name                                       = "AllowGetSessionInformationOutbound"
    description                                = "Required for session and certificate validation."
    priority                                   = 130
    direction                                  = "Outbound"
    access                                     = "Allow"
    protocol                                   = "*"
    source_port_range                          = "*"
    destination_port_range                     = "80"
    source_address_prefix                      = "*"
    destination_address_prefix                 = "Internet"
    source_port_ranges                         = []
    destination_port_ranges                    = []
    source_address_prefixes                    = []
    destination_address_prefixes               = []
    source_application_security_group_ids      = []
    destination_application_security_group_ids = []
  }
}
