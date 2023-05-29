module "app-kv" {
#   source  = "../modules/keyvault"
  source = "git::https://dev.azure.com/NorthernRegion-dev/az-terraform-modules/_git/tf-module-keyvalut"

  create_resource_group          = false
  kv_name = "${var.environment}-${var.solution}-kv-${var.location_short_ae}-1"
  environment = var.environment
  resource_group_name            = azurerm_resource_group.security_rg.name
  location                       = azurerm_resource_group.security_rg.location
  common_tags = local.common_tags
  solution = var.solution

  # Specify Network ACLs
  network_acls = {
    bypass         = "AzureServices"
    default_action = "Deny"
    ip_rules       = ["20.227.10.42"]

    virtual_network_subnet_ids = []
  }

    role_assignments = {
    "Key Vault Secrets User"    = [
        module.pasview-be.app_user_assigned_identity_object_id, 
        module.pasview-fe.app_user_assigned_identity_object_id,
        module.sqlmi.sqlmi_system_identity
        ]
    "Key Vault Crypto Service Encryption User"              = [
      azurerm_user_assigned_identity.sql_sa_user_identity.principal_id
      module.sqlmi.sqlmi_system_identity, 
      azurerm_user_assigned_identity.storage_user_identity.principal_id
      ]
    "Key Vault Secrets Officer" = [
       azurerm_user_assigned_identity.agw_user_identity.principal_id,
       module.mailer-fe.app_user_assigned_identity_object_id
       ]
    "Key Vault Certificates Officer"                     = [
      azurerm_user_assigned_identity.agw_user_identity.principal_id 
      ]

    "Key Vault Crypto Officer"          = [
      azurerm_user_assigned_identity.sql_sa_user_identity.principal_id
       module.sqlmi.sqlmi_system_identity,
       azurerm_user_assigned_identity.storage_user_identity.principal_id
       ]
  }
  private_endpoint_name = "${var.environment}-${var.solution}-kv-pep-${var.location_short_ae}-1"
  private_endpoint_subnet_id = lookup(module.vnet.vnet_subnets_name_id, "${var.environment}-${var.solution}-common-sn-${var.location_short_ae}-1")
}


#---------------------------------------------------------
# SSL certificate for App Gateway
#----------------------------------------------------------


resource "azurerm_key_vault_certificate" "agw_cert" {
  name         = "${var.environment}-${var.solution}-agw-ssl-cert-1"
  key_vault_id = module.app-kv.key_vault_id

  certificate {
    contents = filebase64("azure.centric-prod.hanz.health.nz.pfx")
    password = data.azurerm_key_vault_secret.prod_cert_password.value
  }
}


