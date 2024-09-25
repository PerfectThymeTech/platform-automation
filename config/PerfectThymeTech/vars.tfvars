organization_name = "PerfectThymeTech"
location          = "northeurope"
environment       = "dev"
prefix            = "ptt"
tags              = {}
custom_template_variables = {
  # General variables
  enforcement_mode = "Default",

  # # Logging variables
  # log_analytics_id = "",

  # # DNS Zone variables
  # private_dns_zone_id_appservice_sites            = "",
  # private_dns_zone_id_cognitive_services_account  = "",
  # private_dns_zone_id_open_ai_account             = "",
  # private_dns_zone_id_container_registry_registry = "",
  # private_dns_zone_id_key_vault_vault             = "",
  # private_dns_zone_id_kusto_cluster_northeurope   = "",
  # private_dns_zone_id_kusto_cluster_westeurope    = "",
  # private_dns_zone_id_machine_learning_azure_ml   = "",
  # private_dns_zone_id_machine_learning_notebooks  = "",
  # private_dns_zone_id_search_search_service       = "",
  # private_dns_zone_id_storage_blob                = "",
  # private_dns_zone_id_storage_dfs                 = "",
  # private_dns_zone_id_storage_file                = "",
  # private_dns_zone_id_storage_queue               = "",
  # private_dns_zone_id_storage_table               = "",
  # private_dns_zone_id_storage_web                 = "",
  # private_dns_zone_id_synapse_dev                 = "",
  # private_dns_zone_id_synapse_sql                 = "",
}
connectivity_subscription_id = "e82c5267-9dc4-4f45-ac13-abdd5e130d27"
connectivity_hub = {
  vnet_address_range = "10.0.0.0/16"
  virtual_network_spoke_ids = [
    "/subscriptions/660ed196-9d05-44fc-b902-0c11ca014bd6/resourceGroups/ptt-dev-networking-rg/providers/Microsoft.Network/virtualNetworks/spoke-ptt-dev-vnet001",
    "/subscriptions/9842be63-c8c0-4647-a5d1-0c5e7f8bbb25/resourceGroups/ptt-dev-networking-rg/providers/Microsoft.Network/virtualNetworks/spoke-ptt-dev-vnet001",
    "/subscriptions/1fdab118-1638-419a-8b12-06c9543714a0/resourceGroups/ptt-dev-networking-rg/providers/Microsoft.Network/virtualNetworks/spoke-ptt-dev-vnet001",
  ]
}
management_subscription_id = "e82c5267-9dc4-4f45-ac13-abdd5e130d27"
landing_zone_corp_subscription_ids = [
  "660ed196-9d05-44fc-b902-0c11ca014bd6",
  "9842be63-c8c0-4647-a5d1-0c5e7f8bbb25",
  "1fdab118-1638-419a-8b12-06c9543714a0",
]
