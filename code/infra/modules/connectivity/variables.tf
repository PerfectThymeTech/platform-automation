# General variables
variable "location" {
  description = "Specifies the location for all Azure resources."
  type        = string
  sensitive   = false
  nullable    = false
}

variable "environment" {
  description = "Specifies the environment of the deployment."
  type        = string
  sensitive   = false
  nullable    = false
  default     = "dev"
  validation {
    condition     = contains(["dev", "tst", "qa", "prd"], var.environment)
    error_message = "Please use an allowed value: \"dev\", \"tst\", \"qa\" or \"prd\"."
  }
}

variable "prefix" {
  description = "Specifies the prefix for all resources created in this deployment."
  type        = string
  sensitive   = false
  nullable    = false
  validation {
    condition     = length(var.prefix) >= 2 && length(var.prefix) <= 10
    error_message = "Please specify a prefix with more than two and less than 10 characters."
  }
}

variable "tags" {
  description = "Specifies the tags that you want to apply to all resources."
  type        = map(string)
  sensitive   = false
  nullable    = false
  default     = {}
}

# Connectivity variables
variable "vnet_address_range" {
  description = "Specifies the address range of the vnet."
  type        = string
  sensitive   = false
  validation {
    condition     = length(split("/", var.vnet_address_range)) == 2
    error_message = "Please specify a valid cidr range."
  }
}

variable "log_analytics_workspace_id" {
  description = "Specifies the id of a log analytics workspace, where the log data should be stored."
  type        = string
  sensitive   = false
  validation {
    condition     = length(split("/", var.log_analytics_workspace_id)) == 9 || var.log_analytics_workspace_id == ""
    error_message = "Please specify a valid resource ID."
  }
}

variable "virtual_network_spoke_ids" {
  description = "Specifies the ids of the spoke vnets."
  type        = list(string)
  sensitive   = false
  default     = []
}

variable "management_group_root_id" {
  description = "Specifies the id of the root management group id."
  type        = string
  sensitive   = false
  validation {
    condition     = length(split("/", var.management_group_root_id)) == 5
    error_message = "Please specify a valid resource ID."
  }
}

variable "virtual_machine_admin_username" {
  description = "Specifies the admin username of the jumpbox vm."
  type        = string
  sensitive   = false
  default = "VmMainUser"
  validation {
    condition     = length(var.virtual_machine_admin_username) > 2
    error_message = "Please specify a valid admin username."
  }
}

variable "virtual_machine_admin_password" {
  description = "Specifies the admin password of the jumpbox vm."
  type        = string
  sensitive   = true
  validation {
    condition     = length(var.virtual_machine_admin_password) > 2
    error_message = "Please specify a valid admin password."
  }
}
