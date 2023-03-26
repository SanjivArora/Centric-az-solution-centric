#---------------------------------------------------------
# User Identity Creation for Storage Account
#----------------------------------------------------------

resource "azurerm_user_assigned_identity" "storage_user_identity" {
  location            = azurerm_resource_group.logging_rg.location
  resource_group_name = azurerm_resource_group.logging_rg.name
  name                = "${var.environment}-${var.solution}-auditsa-umi-${var.location_short_ae}-1"

  tags = merge(
    local.common_tags, {
      Name = format("%s", "${var.environment}-${var.solution}-auditsa-umi-${var.location_short_ae}-1")
    }
  )
}

#---------------------------------------------------------
# Storage account customer managed Key encryption
#----------------------------------------------------------

resource "azurerm_key_vault_key" "storage_cmk" {
  name            = "${var.environment}-${var.solution}-cmk-${var.location_short_ae}-1"
  key_vault_id    = module.app-kv.key_vault_id
  key_type        = "RSA-HSM"
  key_size        = 2048
  expiration_date = "2035-04-30T20:00:00Z"

  key_opts = [
    "decrypt",
    "encrypt",
    "sign",
    "unwrapKey",
    "verify",
    "wrapKey",
  ]
  tags = merge(
    var.common_tags, {
      Name            = "${var.environment}-${var.solution}-cmk-${var.location_short_ae}-1"
    }
  )
}

#---------------------------------------------------------
# Storage Account Creation
#----------------------------------------------------------

resource "azurerm_storage_account" "audit_logs" {
  name                      = "${var.environment}${var.solution}auditsa${var.location_short_ae}1"
  location                  = azurerm_resource_group.logging_rg.location
  resource_group_name       = azurerm_resource_group.logging_rg.name
  account_kind              = "StorageV2"
  account_tier              = "Standard"
  account_replication_type  = "LRS"
  min_tls_version           = "TLS1_2"
  enable_https_traffic_only = true
  shared_access_key_enabled = true
  allow_nested_items_to_be_public = false

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.storage_user_identity.id]
  }

  tags = merge(
    local.common_tags, {
      Name = "${var.environment}${var.solution}auditsa${var.location_short_ae}1"
    }
  )
}

#---------------------------------------------------------
# Storage Account conatiner Creation and enable CMK encyprtion 
#----------------------------------------------------------

resource "azurerm_storage_container" "sa_container" {
  name                  = "${var.environment}${var.solution}sqlmi${var.location_short_ae}1"
  storage_account_name  = azurerm_storage_account.audit_logs.name
  container_access_type = "private"
}

resource "azurerm_storage_account_customer_managed_key" "logging" {
  storage_account_id        = azurerm_storage_account.audit_logs.id
  key_vault_id              = module.app-kv.key_vault_id
  key_name                  = azurerm_key_vault_key.storage_cmk.name
  user_assigned_identity_id = azurerm_user_assigned_identity.storage_user_identity.id
}
