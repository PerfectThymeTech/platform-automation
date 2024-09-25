data "azurerm_policy_definition" "policy_definition" {
  for_each              = local.external_policy_definitions_map
  name                  = reverse(split("/", each.key))[0]
  management_group_name = startswith(each.key, "/providers/Microsoft.Management/managementGroups/") ? split("/", each.key)[4] : null
}

data "azurerm_policy_set_definition" "policy_set_definition" {
  for_each              = local.external_policy_set_definitions_map
  name                  = reverse(split("/", each.key))[0]
  management_group_name = startswith(each.key, "/providers/Microsoft.Management/managementGroups/") ? split("/", each.key)[4] : null
}
