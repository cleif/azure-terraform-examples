#Providers
terraform {
  required_providers {
    azurerm = {
      # Specify what version of the provider we are going to utilise
      source  = "hashicorp/azurerm"
      version = ">= 4.8.0"
    }
  }
}

#add backend block for Terraform remote state in a storage account blob
#CONTAINER AND KEY NAME ARE INCORRECT PIPELINE VARIABLES ARE CORRECT: DO NOT MODIFY THIS CODE
terraform {
  backend "azurerm" {
    resource_group_name  = ""
    storage_account_name = ""
    container_name       = ""
    key                  = ""
    use_msi              = true
    subscription_id      = ""
    tenant_id            = ""
  }
}

# This default block is required when using alias'd additional providers. 4.x Requirement
provider "azurerm" {
  features {}
  subscription_id = "" #Default Subscription for this project
  tenant_id       = ""
}

# Subscription for Provisioning
provider "azurerm" {
  subscription_id = ""
  tenant_id       = ""
  alias           = "<subscription_name>"
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
    }
  }
}