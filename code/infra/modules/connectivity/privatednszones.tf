resource "azurerm_private_dns_zone" "private_dns_zone" {
  for_each = toset(local.private_dns_zone_names)

  name                = each.key
  resource_group_name = azurerm_resource_group.resource_group_private_dns.name
}
