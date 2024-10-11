resource "azurerm_bastion_host" "bastion_host" {
  name                = "${local.prefix}-bas001"
  location            = var.location
  resource_group_name = azurerm_resource_group.resource_group_bastion.name
  tags                = var.tags

  copy_paste_enabled = true
  file_copy_enabled  = true
  ip_configuration {
    name                 = "bastion-ip-configuration"
    public_ip_address_id = azurerm_public_ip.public_ip_bastion.id
    subnet_id            = azurerm_subnet.subnet_bastion.id
  }
  ip_connect_enabled     = true
  kerberos_enabled       = false
  scale_units            = 2
  shareable_link_enabled = true
  sku                    = "Standard"
  tunneling_enabled      = false
}
