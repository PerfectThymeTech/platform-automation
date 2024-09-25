output "policy_deployments_completed" {
  description = "Specifies whether the deployments have successfully completed."
  value       = true
  sensitive   = false

  depends_on = [
    azurerm_policy_definition.policy_definitions,
    azurerm_policy_set_definition.policy_set_definitions,
  ]
}
