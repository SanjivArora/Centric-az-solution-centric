resource "azurerm_monitor_activity_log_alert" "z-create-update-nsg-alert" {
  description         = "Alert triggered by Create or Update Network Security Group events"
  name                = "z-create-update-nsg-alert"
  resource_group_name = data.azurerm_resource_group.logging.name
  scopes              = [data.azurerm_subscription.current.id]
  tags      = merge (
    var.common_tags, {
      Name        = "z-create-update-nsg-alert"
      environment = var.environment
    }
  )
  criteria {
    operation_name = "Microsoft.Network/networkSecurityGroups/write"
    category       = "Administrative"
  }
  action {
    action_group_id = var.cloud_team_activity_alerts_action_group_id
  }
}

resource "azurerm_monitor_activity_log_alert" "z-create-policy-assignment-alert" {
  description         = "Alert triggered by Create Policy Assignment events"
  name                = "z-create-policy-assignment-alert"
  resource_group_name = data.azurerm_resource_group.logging.name
  scopes              = [data.azurerm_subscription.current.id]
  tags      = merge (
    var.common_tags, {
      Name        = "z-create-policy-assignment-alert"
      environment = var.environment
    }
  )
  criteria {
    operation_name = "Microsoft.Authorization/policyAssignments/write"
    category       = "Policy"
  }
  action {
    action_group_id = var.cloud_team_activity_alerts_action_group_id
  }
}

resource "azurerm_monitor_activity_log_alert" "z-delete-network-security-group-alert" {
  description         = "Alert triggered by Delete Network Security Group events"
  name                = "z-delete-network-security-group-alert"
  resource_group_name = data.azurerm_resource_group.logging.name
  scopes              = [data.azurerm_subscription.current.id]
  tags      = merge (
    var.common_tags, {
      Name        = "z-delete-network-security-group-alert"
      environment = var.environment
    }
  )
  criteria {
    operation_name = "Microsoft.Network/networkSecurityGroups/delete"
    category       = "Administrative"
  }
  action {
    action_group_id = var.cloud_team_activity_alerts_action_group_id
  }
}

resource "azurerm_monitor_activity_log_alert" "z-create-update-nsg-rule-alert" {
  description         = "Alert triggered by Create or Update Network Security Group Rule events"
  name                = "z-create-update-nsg-rule-alert"
  resource_group_name = data.azurerm_resource_group.logging.name
  scopes              = [data.azurerm_subscription.current.id]
  tags      = merge (
    var.common_tags, {
      Name        = "z-create-update-nsg-rule-alert"
      environment = var.environment
    }
  )
  criteria {
    operation_name = "Microsoft.Network/networkSecurityGroups/securityRules/write"
    category       = "Administrative"
  }
  action {
    action_group_id = var.cloud_team_activity_alerts_action_group_id
  }
}

resource "azurerm_monitor_activity_log_alert" "z-delete-nsg-rule-alert" {
  description         = "Alert triggered by Delete Network Security Group Rule events"
  name                = "z-delete-nsg-rule-alert"
  resource_group_name = data.azurerm_resource_group.logging.name
  scopes              = [data.azurerm_subscription.current.id]
  tags      = merge (
    var.common_tags, {
      Name        = "z-delete-nsg-rule-alert"
      environment = var.environment
    }
  )
  criteria {
    operation_name = "Microsoft.Network/networkSecurityGroups/securityRules/delete"
    category       = "Administrative"
  }
  action {
    action_group_id = var.cloud_team_activity_alerts_action_group_id
  }
}

resource "azurerm_monitor_activity_log_alert" "z-create-update-security-solution-alert" {
  description         = "Alert triggered by Create or Update Security Solution events"
  name                = "z-create-update-security-solution-alert"
  resource_group_name = data.azurerm_resource_group.logging.name
  scopes              = [data.azurerm_subscription.current.id]
  tags      = merge (
    var.common_tags, {
      Name        = "z-create-update-security-solution-alert"
      environment = var.environment
    }
  )
  criteria {
    operation_name = "Microsoft.Security/securitySolutions/write"
    category       = "Administrative"
  }
  action {
    action_group_id = var.cloud_team_activity_alerts_action_group_id
  }
}

resource "azurerm_monitor_activity_log_alert" "z-update-security-policy-alert" {
  description         = "Alert triggered by Update Security Policy events"
  name                = "z-update-security-policy-alert"
  resource_group_name = data.azurerm_resource_group.logging.name
  scopes              = [data.azurerm_subscription.current.id]
  tags      = merge (
    var.common_tags, {
      Name = "z-update-security-policy-alert"
    }
  )
  criteria {
    operation_name = "Microsoft.Security/policies/write"
    category       = "Administrative"
  }
  action {
    action_group_id = var.cloud_team_activity_alerts_action_group_id
  }
}

resource "azurerm_monitor_activity_log_alert" "z-delete-security-solution-alert" {
  description         = "Alert triggered by Delete Security Solution events"
  name                = "z-delete-security-solution-alert"
  resource_group_name = data.azurerm_resource_group.logging.name
  scopes              = [data.azurerm_subscription.current.id]
  tags      = merge (
    var.common_tags, {
      Name = "z-delete-security-solution-alert"
    }
  )
  criteria {
    operation_name = "Microsoft.Security/securitySolutions/delete"
    category       = "Administrative"
  }
  action {
    action_group_id = var.cloud_team_activity_alerts_action_group_id
  }
}

resource "azurerm_monitor_activity_log_alert" "z-create-update-delete-sql-firewall-rule-alert" {
  description         = "Alert triggered by Create, Update or Delete SQL Server Firewall Rule events"
  name                = "z-create-update-delete-sql-firewall-rule-alert"
  resource_group_name = data.azurerm_resource_group.logging.name
  scopes              = [data.azurerm_subscription.current.id]
  tags      = merge (
    var.common_tags, {
      Name = "z-create-update-delete-sql-firewall-rule-alert"
    }
  )
  criteria {
    operation_name = "Microsoft.Sql/servers/firewallRules/write"
    category       = "Administrative"
  }
  action {
    action_group_id = var.cloud_team_activity_alerts_action_group_id
  }
}

resource "azurerm_monitor_activity_log_alert" "z-delete-virtual-machine-alert" {
  description         = "Alert triggered by Delete Virtual Machine events"
  name                = "z-delete-virtual-machine-alert"
  resource_group_name = data.azurerm_resource_group.logging.name
  scopes              = [data.azurerm_subscription.current.id]
  tags      = merge (
    var.common_tags, {
      Name = "z-delete-virtual-machine-alert"
    }
  )
  criteria {
    operation_name = "Microsoft.Compute/virtualMachines/delete"
    category       = "Administrative"
  }
  action {
    action_group_id = var.cloud_team_activity_alerts_action_group_id
  }
}

resource "azurerm_monitor_activity_log_alert" "z-create-update-vm-alert" {
  description         = "Alert triggered by Create or Update Virtual Machine events"
  name                = "z-create-update-vm-alert"
  resource_group_name = data.azurerm_resource_group.logging.name
  scopes              = [data.azurerm_subscription.current.id]
  tags      = merge (
    var.common_tags, {
      Name = "z-create-update-vm-alert"
    }
  )
  criteria {
    operation_name = "Microsoft.Compute/virtualMachines/write"
    category       = "Administrative"
  }
  action {
    action_group_id = var.cloud_team_activity_alerts_action_group_id
  }
}

resource "azurerm_monitor_activity_log_alert" "z-deallocate-virtual-machine-alert" {
  description         = "Alert triggered by Deallocate Virtual Machine events"
  name                = "z-deallocate-virtual-machine-alert"
  resource_group_name = data.azurerm_resource_group.logging.name
  scopes              = [data.azurerm_subscription.current.id]
  tags      = merge (
    var.common_tags, {
      Name = "z-deallocate-virtual-machine-alert"
    }
  )
  criteria {
    operation_name = "Microsoft.Compute/virtualMachines/deallocate/action"
    category       = "Administrative"
  }
  action {
    action_group_id = var.cloud_team_activity_alerts_action_group_id
  }
}

resource "azurerm_monitor_activity_log_alert" "z-power-off-virtual-machine-alert" {
  description         = "Alert triggered by Power Off Virtual Machine events"
  name                = "z-power-off-virtual-machine-alert"
  resource_group_name = data.azurerm_resource_group.logging.name
  scopes              = [data.azurerm_subscription.current.id]
  tags      = merge (
    var.common_tags, {
      Name = "z-power-off-virtual-machine-alert"
    }
  )
  criteria {
    operation_name = "Microsoft.Compute/virtualMachines/powerOff/action"
    category       = "Administrative"
  }
  action {
    action_group_id = var.cloud_team_activity_alerts_action_group_id
  }
}

resource "azurerm_monitor_activity_log_alert" "z-delete-storage-account-alert" {
  description         = "Alert triggered by Delete Storage Account events"
  name                = "z-delete-storage-account-alert"
  resource_group_name = data.azurerm_resource_group.logging.name
  scopes              = [data.azurerm_subscription.current.id]
  tags      = merge (
    var.common_tags, {
      Name = "z-delete-storage-account-alert"
    }
  )
  criteria {
    operation_name = "Microsoft.Storage/storageAccounts/delete"
    category       = "Administrative"
  }
  action {
    action_group_id = var.cloud_team_activity_alerts_action_group_id
  }
}

resource "azurerm_monitor_activity_log_alert" "z-create-update-storage-account-alert" {
  description         = "Alert triggered by Create or Update Storage Account events"
  name                = "z-create-update-storage-account-alert"
  resource_group_name = data.azurerm_resource_group.logging.name
  scopes              = [data.azurerm_subscription.current.id]
  tags      = merge (
    var.common_tags, {
      Name = "z-create-update-storage-account-alert"
    }
  )
  criteria {
    operation_name = "Microsoft.Storage/storageAccounts/write"
    category       = "Administrative"
  }
  action {
    action_group_id = var.cloud_team_activity_alerts_action_group_id
  }
}

resource "azurerm_monitor_activity_log_alert" "z-update-key-vault-alert" {
  description         = "Alert triggered by Update Key Vault events"
  name                = "z-update-key-vault-alert"
  resource_group_name = data.azurerm_resource_group.logging.name
  scopes              = [data.azurerm_subscription.current.id]
  tags      = merge (
    var.common_tags, {
      Name = "z-update-key-vault-alert"
    }
  )
  criteria {
    operation_name = "Microsoft.KeyVault/vaults/write"
    category       = "Administrative"
  }
  action {
    action_group_id = var.cloud_team_activity_alerts_action_group_id
  }
}

resource "azurerm_monitor_activity_log_alert" "z-delete-key-vault-alert" {
  description         = "Alert triggered by Delete Key Vault events"
  name                = "z-delete-key-vault-alert"
  resource_group_name = data.azurerm_resource_group.logging.name
  scopes              = [data.azurerm_subscription.current.id]
  tags      = merge (
    var.common_tags, {
      Name = "z-delete-key-vault-alert"
    }
  )
  criteria {
    operation_name = "Microsoft.KeyVault/vaults/delete"
    category       = "Administrative"
  }
  action {
    action_group_id = var.cloud_team_activity_alerts_action_group_id
  }
}

resource "azurerm_monitor_activity_log_alert" "z-rename-sql-database-alert" {
  description         = "Alert triggered by Rename Azure SQL Database events"
  name                = "z-rename-sql-database-alert"
  resource_group_name = data.azurerm_resource_group.logging.name
  scopes              = [data.azurerm_subscription.current.id]
  tags      = merge (
    var.common_tags, {
      Name = "z-rename-sql-database-alert"
    }
  )
  criteria {
    operation_name = "Microsoft.Sql/servers/databases/move/action"
    category       = "Administrative"
  }
  action {
    action_group_id = var.cloud_team_activity_alerts_action_group_id
  }
}

resource "azurerm_monitor_activity_log_alert" "z-create-update-postgresql-database-alert" {
  description         = "Alert triggered by Create/Update Azure PostgreSQL Database events"
  name                = "z-create-update-postgresql-database-alert"
  resource_group_name = data.azurerm_resource_group.logging.name
  scopes              = [data.azurerm_subscription.current.id]
  tags      = merge (
    var.common_tags, {
      Name = "z-create-update-postgresql-database-alert"
    }
  )
  criteria {
    operation_name = "Microsoft.DBforPostgreSQL/servers/databases/write"
    category       = "Administrative"
  }
  action {
    action_group_id = var.cloud_team_activity_alerts_action_group_id
  }
}

resource "azurerm_monitor_activity_log_alert" "z-delete-postgresql-database-alert" {
  description         = "Alert triggered by Create/Update Azure PostgreSQL Database events"
  name                = "z-delete-postgresql-database-alert"
  resource_group_name = data.azurerm_resource_group.logging.name
  scopes              = [data.azurerm_subscription.current.id]
  tags      = merge (
    var.common_tags, {
      Name = "z-delete-postgresql-database-alert"
    }
  )
  criteria {
    operation_name = "Microsoft.DBforPostgreSQL/servers/databases/delete"
    category       = "Administrative"
  }
  action {
    action_group_id = var.cloud_team_activity_alerts_action_group_id
  }
}

resource "azurerm_monitor_activity_log_alert" "z-create-update-sql-database-alert" {
  description         = "Alert triggered by Create/Update Azure SQL Database events"
  name                = "z-create-update-sql-database-alert"
  resource_group_name = data.azurerm_resource_group.logging.name
  scopes              = [data.azurerm_subscription.current.id]
  tags      = merge (
    var.common_tags, {
      Name = "z-create-update-sql-database-alert"
    }
  )
  criteria {
    operation_name = "Microsoft.Sql/servers/databases/write"
    category       = "Administrative"
  }
  action {
    action_group_id = var.cloud_team_activity_alerts_action_group_id
  }
}

resource "azurerm_monitor_activity_log_alert" "z-delete-sql-database-alert" {
  description         = "Alert triggered by Delete Azure SQL Database events"
  name                = "z-delete-sql-database-alert"
  resource_group_name = data.azurerm_resource_group.logging.name
  scopes              = [data.azurerm_subscription.current.id]
  tags      = merge (
    var.common_tags, {
      Name = "z-delete-sql-database-alert"
    }
  )
  criteria {
    operation_name = "Microsoft.Sql/servers/databases/delete"
    category       = "Administrative"
  }
  action {
    action_group_id = var.cloud_team_activity_alerts_action_group_id
  }
}

resource "azurerm_monitor_activity_log_alert" "z-create-update-load-balancer-alert" {
  description         = "Alert triggered by Create or Update Load Balancer events"
  name                = "z-create-update-load-balancer-alert"
  resource_group_name = data.azurerm_resource_group.logging.name
  scopes              = [data.azurerm_subscription.current.id]
  tags      = merge (
    var.common_tags, {
      Name = "z-create-update-load-balancer-alert"
    }
  )
  criteria {
    operation_name = "Microsoft.Network/loadBalancers/write"
    category       = "Administrative"
  }
  action {
    action_group_id = var.cloud_team_activity_alerts_action_group_id
  }
}

resource "azurerm_monitor_activity_log_alert" "z-delete-load-balancer-alert" {
  description         = "Alert triggered by Delete Load Balancer events"
  name                = "z-delete-load-balancer-alert"
  resource_group_name = data.azurerm_resource_group.logging.name
  scopes              = [data.azurerm_subscription.current.id]
  tags      = merge (
    var.common_tags, {
      Name = "z-delete-load-balancer-alert"
    }
  )
  criteria {
    operation_name = "Microsoft.Network/loadBalancers/delete"
    category       = "Administrative"
  }
  action {
    action_group_id = var.cloud_team_activity_alerts_action_group_id
  }
}

resource "azurerm_monitor_activity_log_alert" "z-create-update-mysql-database-alert" {
  description         = "Alert triggered by Create/Update Azure MySQL Database events"
  name                = "z-create-update-mysql-database-alert"
  resource_group_name = data.azurerm_resource_group.logging.name
  scopes              = [data.azurerm_subscription.current.id]
  tags      = merge (
    var.common_tags, {
      Name = "z-create-update-mysql-database-alert"
    }
  )
  criteria {
    operation_name = "Microsoft.DBforMySQL/servers/databases/write"
    category       = "Administrative"
  }
  action {
    action_group_id = var.cloud_team_activity_alerts_action_group_id
  }
}

resource "azurerm_monitor_activity_log_alert" "z-delete-mysql-database-alert" {
  description         = "Alert triggered by Delete Azure MySQL Database events"
  name                = "z-delete-mysql-database-alert"
  resource_group_name = data.azurerm_resource_group.logging.name
  scopes              = [data.azurerm_subscription.current.id]
  tags      = merge (
    var.common_tags, {
      Name = "z-delete-mysql-database-alert"
    }
  )
  criteria {
    operation_name = "Microsoft.DBforMySQL/servers/databases/delete"
    category       = "Administrative"
  }
  action {
    action_group_id = var.cloud_team_activity_alerts_action_group_id
  }
}

resource "azurerm_monitor_activity_log_alert" "z-delete-policy-assignment-alert" {
  description         = "Alert triggered by Delete Policy Assignment events"
  name                = "z-delete-policy-assignment-alert"
  resource_group_name = data.azurerm_resource_group.logging.name
  scopes              = [data.azurerm_subscription.current.id]
  tags      = merge (
    var.common_tags, {
      Name = "z-delete-policy-assignment-alert"
    }
  )
  criteria {
    operation_name = "Microsoft.Authorization/policyAssignments/delete"
    category       = "Policy"
  }
  action {
    action_group_id = var.cloud_team_activity_alerts_action_group_id
  }
}
