variable "location" {
  description = "Specifies the location of all resources."
  type        = string
  sensitive   = false
  nullable    = false
}

variable "management_group_name" {
  description = "Specifies the management group name."
  type        = string
  sensitive   = false
  nullable    = false
  validation {
    condition     = length(var.management_group_name) > 2
    error_message = "Please provide a valid management group name."
  }
}

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

variable "azure_resources_library_folder" {
  description = "Specifies the base folder to the Azure resources library."
  type        = string
  nullable    = false
  sensitive   = false
}

variable "custom_template_variables" {
  description = "Specifies custom template variables to use for the deployment when loading the Azure resources from the library path."
  type        = map(string)
  sensitive   = false
  nullable    = false
  default     = {}
}

variable "dependency_parent" {
  description = "Specifies a dependency for deployments."
  type        = bool
  sensitive   = false
}

variable "policy_definition_roles_parent" {
  description = "Specifies the roles per policy definition defined in parent scopes."
  type        = map(list(string))
  sensitive   = false
  nullable    = false
  default     = {}
}

variable "policy_set_definition_references_parents" {
  description = "Specifies existing policy set definitions in parent scopes."
  type = map(list(object({
    policy_definition_id           = string
    policy_definition_reference_id = string
    parameters                     = map(any)
    group_names                    = list(string)
  })))
  sensitive = false
  nullable  = false
  default   = {}
}
