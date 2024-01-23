locals {
  azure_policy_definitions_library_path = "${path.root}/../definitions/${var.azure_resources_library_folder}/AzurePolicyDefinitions"
  azure_policy_sets_library_path        = "${path.root}/../definitions/${var.azure_resources_library_folder}/AzurePolicySets"
  azure_policy_assignments_library_path = "${path.root}/../definitions/${var.azure_resources_library_folder}/AzurePolicyAssignments"
  azure_policy_exemptions_library_path  = "${path.root}/../definitions/${var.azure_resources_library_folder}/AzurePolicyExemptions"
  azure_role_definitions_library_path   = "${path.root}/../definitions/${var.azure_resources_library_folder}/AzureRoleDefinitions"

  default_template_variables = {
    # General parameters
    default_location = var.location
    scope_id         = "/providers/Microsoft.Management/managementGroups/${var.management_group_name}"
  }

  template_variables = merge(local.default_template_variables, var.custom_template_variables)
}
