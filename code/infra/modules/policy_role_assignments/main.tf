resource "azurerm_role_assignment" "policy_role_assignment" {
  for_each           = local.role_definition_ids_map
  scope              = var.management_group_id
  role_definition_id = each.value
  principal_id       = var.policy_assignment_principal_id
  description        = "Role definition required for Azure Policy."
}
