resource "azurerm_role_assignment" "uai_role_assignment_" {
  description          = "Required for policy assignments."
  principal_id         = azurerm_user_assigned_identity.user_assigned_identity.principal_id
  principal_type       = "ServicePrincipal"
  role_definition_name = "Contributor"
  scope                = var.management_group_root_id
}
