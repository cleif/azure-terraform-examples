data "azurerm_databricks_workspace" "workspace" {
  name                = var.workspace_name
  resource_group_name = var.workspace_resource_group
}