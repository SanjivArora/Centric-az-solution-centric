#---------------------------------------------------------
# SQL Admin password
#----------------------------------------------------------
resource "random_password" "sql_admin_password" {
  length  = 16
  special = true
}

resource "azurerm_key_vault_secret" "sqlmi_administrator_login_password" {
  name            = "${var.environment}-${var.solution}-sqlmi-${var.location_short_ae}-1-admin-password"
  value           = random_password.sql_admin_password.result
  key_vault_id    = module.app-kv.key_vault_id
  content_type    = "password"
  expiration_date = "2100-12-31T00:00:00Z"
}

#---------------------------------------------------------
# SQL customer managed Key for TDE encryption
#----------------------------------------------------------

resource "azurerm_key_vault_key" "transparent_data_encryption" {
  name         = "${var.environment}-${var.solution}-tdecmk-${var.location_short_ae}-1"
  key_vault_id = module.app-kv.key_vault_id
  key_type     = "RSA"
  key_size     = 2048
  expiration_date = "2035-04-30T20:00:00Z"
  key_opts = [
    "unwrapKey",
    "wrapKey",
  ]
}

#---------------------------------------------------------
# Create SQLMI
#----------------------------------------------------------
module "sqlmi" {
#   source  = "../modules/sqlmi"
  source = "git::https://dev.azure.com/NorthernRegion-DEV/az-terraform-modules/_git/tf-module-sqlmi"

  create_resource_group          = false
  environment = var.environment
  resource_group_name            = azurerm_resource_group.sqlmi_rg.name
  location                       = azurerm_resource_group.sqlmi_rg.location
  common_tags = local.common_tags
  solution = var.solution
  sqlmi_subnet_id = lookup(module.vnet.vnet_subnets_name_id, "${var.environment}-${var.solution}-sqlmi-sn-${var.location_short_ae}-1")
  sql_admin_password = azurerm_key_vault_secret.sqlmi_administrator_login_password.value
  keyvault_key_id = azurerm_key_vault_key.transparent_data_encryption.id
  depends_on = [azurerm_route_table.sqlmi_rt]
  storage_endpoint = azurerm_storage_account.audit_logs.primary_blob_endpoint
  sa_conatiner_path = "${azurerm_storage_account.audit_logs.primary_blob_endpoint}${azurerm_storage_container.sa_container.name}/"
  sa_access_key = azurerm_storage_account.audit_logs.primary_access_key
  ad_admin_group = data.azuread_group.sql_admin_group.display_name
  ad_admin_group_object_id = data.azuread_group.sql_admin_group.object_id
}

resource "azurerm_mssql_managed_database" "centric_db" {
  name                = "Centric_WDHB_DEV"
  managed_instance_id = module.sqlmi.sqlmi_id
}

resource "azurerm_role_assignment" "sqlmi_contributor" {
  scope                = module.sqlmi.sqlmi_id
  role_definition_name = "SQL Managed Instance Contributor"
  principal_id         =  module.mailer-fe.app_user_assigned_identity_object_id
}