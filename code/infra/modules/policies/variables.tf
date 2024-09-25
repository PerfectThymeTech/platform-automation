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

variable "user_assigned_identity_id" {
  description = "Specifies the id of the user assigned identity."
  type        = string
  sensitive   = false
  nullable    = false
  validation {
    condition     = length(split("/", var.user_assigned_identity_id)) == 9
    error_message = "Please provide a valid id."
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
