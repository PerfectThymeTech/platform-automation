organization_name = "PerfectThymeTech"
location          = "northeurope"
environment       = "dev"
prefix            = "ptt"
tags              = {}
custom_template_variables = {
  # General variables
  enforcement_mode = "Default",

  # Logging variables
  log_analytics_id = "",

  # DNS Zone variables
  private_dns_zone_id_appservice_sites            = "",
  private_dns_zone_id_cognitive_services_account  = "",
  private_dns_zone_id_open_ai_account             = "",
  private_dns_zone_id_container_registry_registry = "",
  private_dns_zone_id_key_vault_vault             = "",
  private_dns_zone_id_kusto_cluster_northeurope   = "",
  private_dns_zone_id_kusto_cluster_westeurope    = "",
  private_dns_zone_id_machine_learning_azure_ml   = "",
  private_dns_zone_id_machine_learning_notebooks  = "",
  private_dns_zone_id_search_search_service       = "",
  private_dns_zone_id_storage_blob                = "",
  private_dns_zone_id_storage_dfs                 = "",
  private_dns_zone_id_storage_file                = "",
  private_dns_zone_id_storage_queue               = "",
  private_dns_zone_id_storage_table               = "",
  private_dns_zone_id_storage_web                 = "",
  private_dns_zone_id_synapse_dev                 = "",
  private_dns_zone_id_synapse_sql                 = "",
}
connectivity_subscription_id = ""
management_subscription_id   = ""
identity_subscription_id     = ""
