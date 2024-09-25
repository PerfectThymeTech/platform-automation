output "log_analytics_workspace_id" {
  description = "Specifies the id of the log analytics workspace."
  value       = azurerm_log_analytics_workspace.log_analytics_workspace.id
  sensitive   = false
}

output "user_assigned_identity_id" {
  description = "Specifies the id of the user assigned identity."
  value       = azurerm_user_assigned_identity.user_assigned_identity.id
  sensitive   = false
}
