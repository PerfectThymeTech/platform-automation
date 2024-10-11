resource "azurerm_network_interface" "network_interface" {
  name                = "${local.prefix}-nic001"
  location            = var.location
  resource_group_name = azurerm_resource_group.resource_group_jmpbx.name
  tags                = var.tags

  accelerated_networking_enabled = false
  auxiliary_mode                 = "None"
  auxiliary_sku                  = "None"
  # internal_dns_name_label = ""
  ip_configuration {
    name                          = "nic-network-configuration"
    primary                       = true
    private_ip_address_allocation = "Dynamic"
    private_ip_address_version    = "IPv4"
    subnet_id                     = azurerm_subnet.subnet_jumpbox.id
  }
  ip_forwarding_enabled = false
}

resource "azurerm_windows_virtual_machine" "windows_virtual_machine" {
  name                = "${local.prefix}-jmpbx001"
  location            = var.location
  resource_group_name = azurerm_resource_group.resource_group_jmpbx.name
  tags                = var.tags
  identity {
    type = "SystemAssigned"
  }

  additional_capabilities {
    hibernation_enabled = false
    ultra_ssd_enabled   = false
  }
  # additional_unattend_content {
  #   content = ""
  #   setting = ""
  # }
  admin_username                                         = var.virtual_machine_admin_username
  admin_password                                         = var.virtual_machine_admin_password
  allow_extension_operations                             = true
  bypass_platform_safety_checks_on_user_schedule_enabled = false
  computer_name                                          = "jmpbx001"
  # custom_data                                            = ""
  # disk_controller_type =
  enable_automatic_updates   = true
  encryption_at_host_enabled = true
  hotpatching_enabled        = false
  license_type               = "None"
  network_interface_ids = [
    azurerm_network_interface.network_interface.id,
  ]
  os_disk {
    name                      = "os-disk"
    caching                   = "ReadWrite"
    storage_account_type      = "Standard_LRS"
    write_accelerator_enabled = false
  }
  patch_assessment_mode = "ImageDefault"
  patch_mode            = "AutomaticByOS"
  # platform_fault_domain = -1
  priority            = "Regular"
  provision_vm_agent  = true
  reboot_setting      = "IfRequired"
  secure_boot_enabled = true
  size                = "Standard_DS2_v2"
  source_image_reference {
    offer     = "windows-11"
    publisher = "microsoftwindowsdesktop"
    sku       = "win11-21h4-ent"
    version   = "latest"
  }
  termination_notification {
    enabled = false
  }
  timezone = "UTC"
  # user_data                         = ""
  vm_agent_platform_updates_enabled = true
  vtpm_enabled                      = true
}
