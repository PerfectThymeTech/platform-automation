locals {
  # Generate map with policy assignment ID in case an individual policy gets assigned instead of an initiative
  policy_definition_id_map = {
    reverse(split("/", var.policy_definition_id))[0] = var.policy_definition_id
  }

  # Generate map with policy definition name from policy set reference object
  policy_definition_references_map = {
    for policy_definition_reference in var.policy_definition_references :
    try(policy_definition_reference.policy_definition_reference_id, "") => try(policy_definition_reference.policy_definition_id, "")
  }

  # Generate list of role definition ids for role assignment
  role_definition_ids_list = compact(flatten([
    for key, value in merge(local.policy_definition_references_map, local.policy_definition_id_map) :
    lookup(var.policy_definition_roles, value, [])
  ]))
  role_definition_ids_distinct_list = distinct([
    for role_definition_id in local.role_definition_ids_list :
    lower(role_definition_id)
  ])
  role_definition_ids_map = {
    for role_definition_id in local.role_definition_ids_distinct_list :
    role_definition_id => role_definition_id
  }
}
