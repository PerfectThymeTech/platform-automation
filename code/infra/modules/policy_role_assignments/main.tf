resource "azurerm_role_assignment" "policy_role_assignment" {
  for_each           = local.role_definition_ids_map

  description        = "Role definition required for Azure Policy."
  principal_id       = var.policy_assignment_principal_id
  role_definition_id = each.value
  scope              = var.management_group_id
}
