#NO OVERRIDES
module "example_policy_use_no_overrides" {
  source = "<path to module>"

  policy_type = "job"

  workspace_name           = azurerm_databricks_workspace.workspace01.name 
  workspace_resource_group = azurerm_resource_group.rg_for_workspace.name                
  policy_name              = "Job FS Compute Family"
  # Compute Selections
  worker_node_allow_list = ["Standard_D8ds_v5"]
  driver_node_allow_list = ["Standard_E32ds_v5", "Standard_E32ds_v4"]
  tag1  = ["tag1"]
  
  can_use_groups         = ["group1","group2","group3"]
  policy_overrides       = {} #Leave Empty if no overrides are needed
}

#WITH OVERRIDES
module "poc_sf_migration_policy_dev" {
  source = "<path to module>"

  policy_type = "all-purpose"

  workspace_name           = azurerm_databricks_workspace.workspace01.name 
  workspace_resource_group = azurerm_resource_group.rg_for_workspace.name                
  policy_name              = "Job FS Compute Family"
  # Compute Selections
  worker_node_allow_list = ["Standard_D8ds_v5"]
  driver_node_allow_list = ["Standard_E32ds_v5", "Standard_E32ds_v4"]
  tag1  = ["tag1"]
  
  can_use_groups         = ["group1","group2","group3"]
  policy_overrides = {
    "autotermination_minutes" : {
      "type" : "fixed",
      "value" : 30,
      "hidden" : false,
      "readOnly" : true
    },
    "runtime_engine" : {
      "type" : "fixed",
      "value" : "PHOTON",
      "hidden" : false,
      "readOnly" : true
    },
    "data_security_mode" : {
      "type" : "fixed",
      "value" : "USER_ISOLATION",
      "hidden" : false,
      "readOnly" : true
    },
    "autoscale.max_workers": {
    "type": "range",
    "maxValue": 12,
    "defaultValue": 1
    }
  } #Leave Empty if no overrides are needed
}