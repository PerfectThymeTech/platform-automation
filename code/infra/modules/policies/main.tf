resource "azurerm_policy_definition" "policy_definitions" {
  for_each = local.azure_policy_definitions

  name                = try(each.value.name, "")
  management_group_id = var.management_group_id

  display_name = try(each.value.properties.displayName, "")
  description  = try(each.value.properties.description, "")
  policy_type  = try(each.value.properties.policyType, "")
  mode         = try(each.value.properties.mode, "")
  metadata     = jsonencode(try(each.value.properties.metadata, ""))
  parameters   = jsonencode(try(each.value.properties.parameters, ""))
  policy_rule  = jsonencode(try(each.value.properties.policyRule, ""))

  lifecycle {
    create_before_destroy = true
  }
}

resource "azurerm_policy_set_definition" "policy_set_definitions" {
  for_each = local.azure_policy_set_definitions

  name                = try(each.value.name, "")
  management_group_id = var.management_group_id

  display_name = try(each.value.properties.displayName, "")
  description  = try(each.value.properties.description, "")
  policy_type  = try(each.value.properties.policyType, "")
  metadata     = jsonencode(try(each.value.properties.metadata, ""))
  parameters   = jsonencode(try(each.value.properties.parameters, ""))
  dynamic "policy_definition_group" {
    for_each = try(each.value.properties.policyDefinitionGroups, [])
    content {
      name         = policy_definition_group.value.name
      category     = policy_definition_group.value.category
      display_name = policy_definition_group.value.displayName
      description  = policy_definition_group.value.description
    }
  }
  dynamic "policy_definition_reference" {
    for_each = try(each.value.properties.policyDefinitions, [])
    content {
      policy_definition_id = policy_definition_reference.value.policyDefinitionId
      parameter_values     = jsonencode(policy_definition_reference.value.parameters)
      policy_group_names   = policy_definition_reference.value.groupNames
      reference_id         = policy_definition_reference.value.policyDefinitionReferenceId
    }
  }

  depends_on = [
    azurerm_policy_definition.policy_definitions
  ]
}

resource "azurerm_management_group_policy_assignment" "policy_assignments" {
  for_each = local.azure_policy_assignment_definitions

  name                = try(each.value.name, "")
  management_group_id = var.management_group_id
  location            = var.location
  identity {
    type = "SystemAssigned"
  }

  display_name         = try(each.value.properties.displayName, "")
  description          = try(each.value.properties.description, "")
  enforce              = try(each.value.properties.enforcementMode, "Default") == "Default" ? true : false
  metadata             = jsonencode(try(each.value.properties.metadata, ""))
  parameters           = jsonencode(try(each.value.properties.parameters, ""))
  policy_definition_id = try(each.value.properties.policyDefinitionId, "")
  not_scopes           = try(each.value.properties.notScopes, [])

  dynamic "non_compliance_message" {
    for_each = try(each.value.properties.nonComplianceMessages, [])
    content {
      content                        = non_compliance_message.value.message
      policy_definition_reference_id = non_compliance_message.value.policyDefinitionReferenceId
    }
  }
  dynamic "overrides" {
    for_each = try(each.value.properties.overrides, [])
    content {
      value = overrides.value.value
      dynamic "selectors" {
        for_each = overrides.value.selectors
        content {
          in     = selectors.value.in
          not_in = selectors.value.notIn
        }
      }
    }
  }
  dynamic "resource_selectors" {
    for_each = try(each.value.properties.resourceSelectors, [])
    content {
      name = resource_selectors.value.name
      dynamic "selectors" {
        for_each = resource_selectors.value.selectors
        content {
          in     = selectors.value.in
          kind   = selectors.value.kind
          not_in = selectors.value.notIn
        }
      }
    }
  }

  depends_on = [
    azurerm_policy_set_definition.policy_set_definitions,
    var.dependency_parent
  ]
}

resource "azurerm_management_group_policy_exemption" "policy_exemptions" {
  for_each = local.azure_policy_exemption_definitions

  name                = try(each.value.name, "")
  management_group_id = var.management_group_id

  display_name                    = try(each.value.properties.displayName, "")
  description                     = try(each.value.properties.description, "")
  expires_on                      = try(each.value.properties.expiresOn, null)
  exemption_category              = try(each.value.exemptionCategory, "Waiver")
  metadata                        = jsonencode(try(each.value.properties.metadata, ""))
  policy_assignment_id            = try(each.value.policyAssignmentId, "")
  policy_definition_reference_ids = try(each.value.properties.policyDefinitionReferenceIds, [])

  depends_on = [
    azurerm_management_group_policy_assignment.policy_assignments,
    var.dependency_parent
  ]
}

resource "azurerm_role_definition" "role_definitions" {
  for_each = local.azure_role_definitions

  name  = try(each.value.name, "")
  scope = var.management_group_id

  assignable_scopes = try(each.value.properties.assignableScopes, [])
  description       = try(each.value.properties.description, "")
  permissions {
    actions          = try(each.value.properties.permissions[0].actions, [])
    not_actions      = try(each.value.properties.permissions[0].notActions, [])
    data_actions     = try(each.value.properties.permissions[0].dataActions, [])
    not_data_actions = try(each.value.properties.permissions[0].notDataActions, [])
  }
}
