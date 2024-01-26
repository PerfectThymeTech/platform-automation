locals {
  prefix = "${lower(var.prefix)}-${var.environment}"

  private_dns_zone_names = [
    # Azure ML
    "privatelink.api.azureml.ms",
    "privatelink.notebooks.azure.net",

    # Azure AI Services
    "privatelink.cognitiveservices.azure.com",
    "privatelink.openai.azure.com",

    # Azure Bot Services
    "privatelink.directline.botframework.com",
    "privatelink.token.botframework.com",

    # Azure Synapse Analytics
    "privatelink.sql.azuresynapse.net",
    "privatelink.dev.azuresynapse.net",
    "privatelink.azuresynapse.net",

    # Azure Event Hubs/Azure Service Bus/Azure Relay
    "privatelink.servicebus.windows.net",

    # Azure Event Grid
    "privatelink.eventgrid.azure.net",

    # Azure Data Factory
    "privatelink.datafactory.azure.net",
    "privatelink.adf.azure.com",

    # Azure HDInsight
    "privatelink.azurehdinsight.net",

    # Azure Data Explorer
    "privatelink.${var.location}.kusto.windows.net",

    # Microsoft Power BI
    "privatelink.analysis.windows.net",
    "privatelink.pbidedicated.windows.net",
    "privatelink.tip1.powerquery.microsoft.com",

    # Azure Databricks
    "privatelink.azuredatabricks.net",

    # Azure Batch
    "${var.location}.privatelink.batch.azure.com",
    "${var.location}.service.privatelink.batch.azure.com",

    # Azure Virtual Desktop
    "privatelink-global.wvd.microsoft.com",
    "privatelink.wvd.microsoft.com",
    "privatelink.wvd.microsoft.com",

    # Azure Kubernetes Service
    "privatelink.${var.location}.azmk8s.io",

    # Azure Container Registry
    "privatelink.azurecr.io",
    "${var.location}.data.privatelink.azurecr.io",

    # Azure SQL Database
    "privatelink.database.windows.net",

    # Azure SQL Managed Instance
    # "privatelink.{dnsPrefix}.database.windows.net",

    # Azure Cosmos DB
    "privatelink.documents.azure.com",
    "privatelink.mongo.cosmos.azure.com",
    "privatelink.cassandra.cosmos.azure.com",
    "privatelink.gremlin.cosmos.azure.com",
    "privatelink.table.cosmos.azure.com",
    "privatelink.analytics.cosmos.azure.com",
    "privatelink.postgres.cosmos.azure.com",

    # Azure Database for PostgreSQL
    "privatelink.postgres.database.azure.com",

    # Azure Database for MySQL
    "privatelink.mysql.database.azure.com",

    # Azure Database for MariaDB
    "privatelink.mariadb.database.azure.com",

    # Azure Cache for Redis
    "privatelink.redis.cache.windows.net",
    "privatelink.redisenterprise.cache.azure.net",

    # Azure Arc
    "privatelink.his.arc.azure.com",
    "privatelink.guestconfiguration.azure.com",
    "privatelink.dp.kubernetesconfiguration.azure.com",

    # Azure API Management
    "privatelink.azure-api.net",

    # Azure Health Data Services
    "privatelink.workspace.azurehealthcareapis.com",
    "privatelink.fhir.azurehealthcareapis.com",
    "privatelink.dicom.azurehealthcareapis.com",

    # Azure IoT Hub
    "privatelink.azure-devices.net",
    "privatelink.azure-devices-provisioning.net",
    "privatelink.api.adu.microsoft.com",

    # Azure IoT Central
    "privatelink.azureiotcentral.com",

    # Azure Digital Twins
    "privatelink.digitaltwins.azure.net",

    # Azure Media Services
    "privatelink.media.azure.net",

    # Azure Automation
    "privatelink.azure-automation.net",

    # Azure Backup
    "privatelink.${var.location}.backup.windowsazure.com",

    # Azure Site Recovery
    "privatelink.siterecovery.windowsazure.com",

    # Azure Monitor
    "privatelink.monitor.azure.com",
    "privatelink.oms.opinsights.azure.com",
    "privatelink.ods.opinsights.azure.com",
    "privatelink.agentsvc.azure-automation.net",

    # Microsoft Purview
    "privatelink.purview.azure.com",
    "privatelink.purviewstudio.azure.com",

    # Azure Migrate
    "privatelink.prod.migration.windowsazure.com",

    # Azure Resource Manager
    # "privatelink.azure.com",

    # Azure Managed Grafana
    "privatelink.grafana.azure.com",

    # Azure Key Vault
    "privatelink.vaultcore.azure.net",
    "privatelink.managedhsm.azure.net",

    # Azure App Configuration
    "privatelink.azconfig.io",

    # Azure Attestation
    "privatelink.attest.azure.net",

    # Azure Storage
    "privatelink.blob.core.windows.net",
    "privatelink.table.core.windows.net",
    "privatelink.queue.core.windows.net",
    "privatelink.file.core.windows.net",
    "privatelink.web.core.windows.net",
    "privatelink.dfs.core.windows.net",
    "privatelink.afs.azure.net",

    # Azure Search
    "privatelink.search.windows.net",

    # Azure Web Apps/Azure Function/Azure Logic Apps
    "privatelink.azurewebsites.net",

    # SignalR
    "privatelink.service.signalr.net",

    # Azure Static Web Apps
    "privatelink.azurestaticapps.net",
    # "privatelink.{partitionId}.azurestaticapps.net",
  ]
}
