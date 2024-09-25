resource "azurerm_role_assignment" "uai_role_assignment_contributor" {
  description          = "Role assignment required for automation via UAI."
  scope                = "/subscriptions/${data.azurerm_client_config.current.subscription_id}"
  role_definition_name = "Contributor"
  principal_id         = azurerm_user_assigned_identity.user_assigned_identity.principal_id
  principal_type       = "ServicePrincipal"
}

resource "azurerm_role_assignment" "uai_role_assignment_user_access_administrator" {
  description          = "Role assignment required for automation via UAI."
  scope                = "/subscriptions/${data.azurerm_client_config.current.subscription_id}"
  role_definition_name = "User Access Administrator"
  principal_id         = azurerm_user_assigned_identity.user_assigned_identity.principal_id
  principal_type       = "ServicePrincipal"
}
