output "private_dns_zone_ids" {
  description = "Specifies the map of the private dns zones."
  value = {
    for item in local.private_dns_zone_names :
    item => azurerm_private_dns_zone.private_dns_zone[item].id
  }
  sensitive = false
}

output "azurerm_firewall" {
  description = "Specifies the private IP address of the Azure Firewall."
  value       = azurerm_firewall.firewall.ip_configuration[0].private_ip_address
  sensitive   = false
}
