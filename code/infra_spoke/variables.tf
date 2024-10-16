# General variables
variable "location" {
  description = "Specifies the location for all Azure resources."
  type        = string
  sensitive   = false
}

variable "environment" {
  description = "Specifies the environment of the deployment."
  type        = string
  sensitive   = false
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
  validation {
    condition     = length(var.prefix) >= 2 && length(var.prefix) <= 10
    error_message = "Please specify a prefix with more than two and less than 10 characters."
  }
}

variable "tags" {
  description = "Specifies the tags that you want to apply to all resources."
  type        = map(string)
  sensitive   = false
  default     = {}
}

# Management Group variables
variable "management_group_name" {
  description = "Specifies the name of the management group to which the subscription should be associated with."
  type        = string
  sensitive   = false
  validation {
    condition     = length(var.management_group_name) >= 2 && length(var.management_group_name) <= 64
    error_message = "Please provide a valid management group name."
  }
}

# Network variables
variable "vnet_spoke_details" {
  description = "Specifies the network configuration used for the spoke virtual networks."
  type = object({
    enabled             = optional(bool, false)
    name_prefix         = optional(string, "spoke-vnet")
    address_prefixes    = optional(list(string), [])
    dns_servers         = optional(list(string), [])
    firewall_private_ip = string
  })
  sensitive = false
}
