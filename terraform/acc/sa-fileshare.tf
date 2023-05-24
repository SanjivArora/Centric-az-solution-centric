#---------------------------------------------------------
# User Identity Creation for Storage Account
#----------------------------------------------------------

resource "azurerm_user_assigned_identity" "sql_sa_user_identity" {
  location            = azurerm_resource_group.sqlmi_rg.location
  resource_group_name = azurerm_resource_group.sqlmi_rg.name
  name                = "${var.environment}-${var.solution}-sqlsa-umi-${var.location_short_ae}-1"

  tags = merge(
    local.common_tags, {
      Name = format("%s", "${var.environment}-${var.solution}-sqlsa-umi-${var.location_short_ae}-1")
    }
  )
}

#---------------------------------------------------------
# Storage account customer managed Key encryption
#----------------------------------------------------------

resource "azurerm_key_vault_key" "sql_sa_cmk" {
  name            = "${var.environment}-${var.solution}-sqlsa-cmk-${var.location_short_ae}-1"
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
      Name            = "${var.environment}-${var.solution}-sqlsa-cmk-${var.location_short_ae}-1"
    }
  )
}

#---------------------------------------------------------
# Storage Account Creation
#----------------------------------------------------------

resource "azurerm_storage_account" "sql_sa" {
  name                      = "${var.environment}${var.solution}sqlsa${var.location_short_ae}1"
  location                  = azurerm_resource_group.sqlmi_rg.location
  resource_group_name       = azurerm_resource_group.sqlmi_rg.name
  account_kind              = "StorageV2"
  account_tier              = "Standard"
  account_replication_type  = "LRS"
  min_tls_version           = "TLS1_2"
  enable_https_traffic_only = true
  shared_access_key_enabled = true
  allow_nested_items_to_be_public = false

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.sql_sa_user_identity.id]
  }

  network_rules {
    bypass         = ["AzureServices"]
    default_action = "Deny"
    ip_rules       = ["20.227.10.42"]
    virtual_network_subnet_ids = []
  }

  customer_managed_key {
    key_vault_key_id = azurerm_key_vault_key.sql_sa_cmk.id
    user_assigned_identity_id = azurerm_user_assigned_identity.sql_sa_user_identity.id
  }

  tags = merge(
    local.common_tags, {
      Name = "${var.environment}${var.solution}sqlsa${var.location_short_ae}1"
    }
  )
}

#---------------------------------------------------------
# Storage Account container Creation and enable CMK encyprtion 
#----------------------------------------------------------

resource "azurerm_storage_share" "sql_sa_share" {
  name                  = "${var.environment}${var.solution}sqlmi${var.location_short_ae}1"
  storage_account_name  = azurerm_storage_account.sql_sa.name
  quota = 100
}

#---------------------------------------------------------
# Create a Private Endpoint for Storage Account
#----------------------------------------------------------

resource "azurerm_private_endpoint" "sql_sa_pep" {
  name                = "${var.environment}-${var.solution}-sqlsa-pep-${var.location_short_ae}-1"
  location            = azurerm_resource_group.sqlmi_rg.location
  resource_group_name = azurerm_resource_group.sqlmi_rg.name
  subnet_id           = lookup(module.vnet.vnet_subnets_name_id, "${var.environment}-${var.solution}-common-sn-${var.location_short_ae}-1")

  private_dns_zone_group {
    name = "${var.environment}-${var.solution}-sqlsa-pepdns-${var.location_short_ae}-1"
    private_dns_zone_ids = ["/subscriptions/ca095a5d-36c0-4d4f-82ff-83580d85ebba/resourceGroups/sha-infra-dns-rg-ae-1/providers/Microsoft.Network/privateDnsZones/privatelink.file.core.windows.net"]
  }

  private_service_connection {
    name = "${var.environment}-${var.solution}-sqlsa-pep-${var.location_short_ae}-1"
    private_connection_resource_id = azurerm_storage_account.sql_sa.id
    subresource_names = ["file"]
    is_manual_connection = false
  }
  tags     = merge(
    local.common_tags, { 
      Name = format("%s", "${var.environment}-${var.solution}-sqlsa-pep-${var.location_short_ae}-1")
    } 
  )
}