locals {
  # Get referenced policy definition IDs in policy assignments
  azure_policy_assignments_policy_reference_id_list = distinct(compact([
    for key, value in local.azure_policy_assignment_definitions :
    try(value.properties.policyDefinitionId, null)
  ]))
  # Split list into policy definitions and policy set definitions
  azure_policy_assignments_policy_set_id_list = compact([
    for policy_reference_id in local.azure_policy_assignments_policy_reference_id_list :
    strcontains(policy_reference_id, "Microsoft.Authorization/policySetDefinitions") ? policy_reference_id : null
  ])
  azure_policy_assignments_policy_definition_id_list = compact([
    for policy_reference_id in local.azure_policy_assignments_policy_reference_id_list :
    strcontains(policy_reference_id, "Microsoft.Authorization/policyDefinitions") ? policy_reference_id : null
  ])
}

locals {
  # Get details of policy sets managed by this module
  internal_policy_set_definition_references = {
    for key, value in local.azure_policy_set_definitions :
    "${local.template_variables.scope_id}/providers/Microsoft.Authorization/policySetDefinitions/${try(value.name, "")}" => [
      for policy_definition_reference in try(value.properties.policyDefinitions, []) : {
        policy_definition_id           = policy_definition_reference.policyDefinitionId,
        policy_definition_reference_id = policy_definition_reference.policyDefinitionReferenceId,
        parameters                     = policy_definition_reference.parameters,
        group_names                    = policy_definition_reference.groupNames,
      }
    ]
  }
  internal_policy_set_definition_references_merged = merge(local.internal_policy_set_definition_references, var.policy_set_definition_references_parents)

  # Get list of policy sets NOT managed by this module to load details via data resource
  external_policy_set_definitions_list = distinct(compact([
    for policy_set_id in local.azure_policy_assignments_policy_set_id_list :
    contains(keys(local.internal_policy_set_definition_references_merged), policy_set_id) ? null : policy_set_id
  ]))
  external_policy_set_definitions_map = {
    for external_policy_set_definition in local.external_policy_set_definitions_list :
    external_policy_set_definition => external_policy_set_definition
  }

  # Get details of policy sets NOT managed by this module
  # external_policy_set_definition_references = {
  #   for key, value in data.azurerm_policy_set_definition.policy_set_definition :
  #   key => [
  #     for policy_definition_reference in value.policy_definition_reference : {
  #       policy_definition_id           = policy_definition_reference.policy_definition_id,
  #       policy_definition_reference_id = policy_definition_reference.reference_id,
  #       parameters                     = policy_definition_reference.parameter_values,
  #       group_names                    = policy_definition_reference.policy_group_names,
  #     }
  #   ]
  # }
  external_policy_set_definition_references = {
    for key, value in local.external_policy_set_definitions_map :
    key => [
      for policy_definition_reference in data.azurerm_policy_set_definition.policy_set_definition[key].policy_definition_reference : {
        policy_definition_id           = policy_definition_reference.policy_definition_id,
        policy_definition_reference_id = policy_definition_reference.reference_id,
        parameters                     = policy_definition_reference.parameter_values,
        group_names                    = policy_definition_reference.policy_group_names,
      }
    ]
  }

  # Get combined details of policy sets
  policy_set_definition_references = merge(local.internal_policy_set_definition_references_merged, local.external_policy_set_definition_references)
}

locals {
  # Get policy role definitions of policies managed by this module
  internal_policy_definition_roles = {
    for key, value in local.azure_policy_definitions :
    "${local.template_variables.scope_id}/providers/Microsoft.Authorization/policyDefinitions/${try(value.name, "")}" => try(value.properties.policyRule.then.details.roleDefinitionIds, [])
  }
  internal_policy_definition_roles_merged = merge(local.internal_policy_definition_roles, var.policy_definition_roles_parent)

  # Get list of policies NOT managed by this module to load details via data resource
  ## Sceanrio 1: Filter the external policies from the assignments
  external_policy_definitions_001_list = distinct(compact([
    for azure_policy_assignments_policy_definition_id in local.azure_policy_assignments_policy_definition_id_list :
    contains(keys(local.internal_policy_definition_roles_merged), azure_policy_assignments_policy_definition_id) ? null : azure_policy_assignments_policy_definition_id
  ]))
  ## Scenario 2: Filter referenced Policies from policy sets
  external_policy_definitions_002_list = distinct(compact(flatten([
    for key, value in local.policy_set_definition_references : [
      for policy_definition_reference in value :
      contains(keys(local.internal_policy_definition_roles_merged), policy_definition_reference.policy_definition_id) ? null : policy_definition_reference.policy_definition_id
    ]
  ])))
  external_policy_definitions_list = distinct(concat(local.external_policy_definitions_001_list, local.external_policy_definitions_002_list))
  external_policy_definitions_map = {
    for external_policy_definition in local.external_policy_definitions_list :
    external_policy_definition => external_policy_definition
  }

  # Get policy role definitions of policies NOT managed by this module
  external_policy_definition_roles = {
    for key, value in data.azurerm_policy_definition.policy_definition :
    value.id => value.role_definition_ids
  }

  # Get combined policy role definitions
  policy_definition_roles = merge(
    local.internal_policy_definition_roles_merged,
    local.external_policy_definition_roles
  )
}
