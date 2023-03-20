variable "common_tags" {
  description = "Common tags applied to all the resources created in this module"
  type        = map(string)
}

variable "rg_name" {
  description = "Name of the resource group to use"
  type        = string
}

variable "environment" {
  description = "Environment the resources will be used for"
  type        = string
}

variable "cloud_team_activity_alerts_action_group_id" {
  description = "Name of the solution being deployed"
  type        = string
  default = "/subscriptions/e98069cd-4865-409c-ba3a-3cff06940d7e/resourceGroups/sha-management-monitoring-rg-ae-1/providers/Microsoft.Insights/actionGroups/ActionGroup-CloudTeamActivityAlerts"
}