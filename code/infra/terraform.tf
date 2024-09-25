terraform {
  required_version = ">=0.13"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.3.0"
    }
    azapi = {
      source  = "azure/azapi"
      version = "1.15.0"
    }
  }

  backend "azurerm" {
    environment          = "public"
    resource_group_name  = "<provided-via-config>"
    storage_account_name = "<provided-via-config>"
    container_name       = "<provided-via-config>"
    key                  = "<provided-via-config>"
    use_azuread_auth     = true
  }
}
