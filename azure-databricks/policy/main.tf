resource "databricks_cluster_policy" "policy" {
  provider   = databricks.selected_workspace
  name       = "${var.policy_name}"
  definition = jsonencode(merge(local.module_policy, var.policy_overrides))
}


resource "databricks_permissions" "policy_permissions" {
  provider          = databricks.selected_workspace
  cluster_policy_id = databricks_cluster_policy.policy.id

  dynamic "access_control" {
    for_each = var.can_use_groups
    content {
      group_name = access_control.value
      permission_level = "CAN_USE"
    }
  }
}
