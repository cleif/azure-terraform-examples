variable "workspace_name" {
  type = string
}

variable "workspace_resource_group" {
  type = string
}

variable "policy_name" {
  type = string
}

variable "can_use_groups" {
  type = list
}

variable "policy_overrides" {
  description = "Cluster Policy Override Capabilities. Required JSON configuration"
}

variable "worker_node_allow_list" {
}

variable "driver_node_allow_list" {
}

variable "cd_portfolio_tag_list" {
  description = "this is used to narrow the tagging allow list scopes to the appropriate portfolio/products"
}

variable "cd_product_tag_list" {
  description = "this is used to narrow the tagging allow list scopes to the appropriate portfolio/products"
}

variable "policy_type" {
  default = "all-purpose"
}

locals {
  module_policy = {
    "cluster_type": {
      "type": "fixed",
      "value": var.policy_type
    },
    "node_type_id" : {
      "type" : "allowlist",
      "values" : var.worker_node_allow_list
      "defaultValue" : "Standard_D4s_v5"
    },
    "autotermination_minutes" : {
      "type" : "range",
      "minValue" : 0,
      "maxValue" : 90,
      "defaultValue" : 20,
      "isOptional" : false
    },
    "driver_node_type_id" : {
      "type" : "allowlist",
      "values" : var.driver_node_allow_list
      "defaultValue" : "Standard_D4s_v5",
      "isOptional" : false
    },
    "custom_tags.tag1" : {
      "type" : "allowlist",
      "values" : var.cd_product_tag_list
      "isOptional" : false
    }
  }
}