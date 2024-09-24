terraform {
  required_version = ">=0.13"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.73.0"
    }
    azapi = {
      source  = "azure/azapi"
      version = "1.9.0"
    }
  }
}
