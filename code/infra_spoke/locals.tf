locals {
  prefix = "${lower(var.prefix)}-${var.environment}"

  # Resource providers to register
  resource_providers_to_register = [
    "Microsoft.Authorization",
    "Microsoft.EventGrid",
    "Microsoft.Insights",
    "Microsoft.KeyVault",
    "Microsoft.Management",
    "Microsoft.Network",
    "Microsoft.OperationsManagement",
    "Microsoft.OperationalInsights",
    "Microsoft.Resources",
    "Microsoft.Storage",
    "Microsoft.Security",
    "Microsoft.SecurityInsights",
  ]
}
