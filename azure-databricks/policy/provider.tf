terraform {
  required_providers {
    databricks = {
      source  = "databricks/databricks"
      version = "1.44.0"
    }
    azuread = {
      source  = "hashicorp/azuread"
      version = "2.50.0"
    }
  }
}

provider "databricks" {
  alias                       = "selected_workspace"
  azure_workspace_resource_id = data.azurerm_databricks_workspace.workspace.id
  host                        = data.azurerm_databricks_workspace.workspace.workspace_url
  azure_tenant_id             = "6b0d6faa-4dc1-485c-ac89-6a4aae225fbd"
}

