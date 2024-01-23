variable "management_group_id" {
  description = "Specifies the management group deployment scope. Must start with '/providers/Microsoft.Management/managementGroups/...'."
  type        = string
  sensitive   = false
  nullable    = false
  validation {
    condition     = startswith(var.management_group_id, "/providers/Microsoft.Management/managementGroups/")
    error_message = "Please provide a valid management group id."
  }
}

variable "policy_assignment_principal_id" {
  description = "Specifies the principal id of the policy assignment."
  type        = string
  sensitive   = false
}

variable "policy_definition_id" {
  description = "Specifies the id of the policy (set) that was assigned."
  type        = any
  sensitive   = false
}

variable "policy_definition_references" {
  description = "Specifies the id of the policy set definition."
  type = list(object({
    policy_definition_id           = string
    policy_definition_reference_id = string
    parameters                     = map(any)
    group_names                    = list(string)
  }))
  sensitive = false
}

variable "policy_definition_roles" {
  description = "Specifies the roles per policy definition."
  type        = map(list(string))
  sensitive   = false
}
