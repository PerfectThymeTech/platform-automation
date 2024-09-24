output "log_analytics_workspace_id" {
  description = "Specifies the id of the log analytics workspace."
  value       = azurerm_log_analytics_workspace.log_analytics_workspace.id
  sensitive   = false
}
