output "policy_assignment_references" {
  description = "Specifies the Policy Assignment details."
  sensitive   = false
  value = {
    for key, value in azurerm_management_group_policy_assignment.policy_assignments :
    key => {
      principal_id         = value.identity[0].principal_id,
      policy_definition_id = value.policy_definition_id
    }
  }
}

output "policy_set_definition_references" {
  description = "Specifies the details of policy sets managed at this scope and at parent scopes."
  sensitive   = false
  value       = local.internal_policy_set_definition_references_merged # local.policy_set_definition_references
}

output "policy_definition_roles" {
  description = "Specifies the role definitions of policies managed at this scope and at parent scopes."
  sensitive   = false
  value       = local.policy_definition_roles
}

output "policy_deployments_completed" {
  description = "Specifies whether the deployments have successfully completed."
  value       = true
  sensitive   = false

  depends_on = [
    azurerm_policy_definition.policy_definitions,
    azurerm_policy_set_definition.policy_set_definitions,
  ]
}
