module "app-kv" {
  source  = "../modules/keyvault"

  create_resource_group          = false
  environment = var.environment
  resource_group_name            = azurerm_resource_group.common_rg.name
  location                       = azurerm_resource_group.common_rg.location
  common_tags = local.common_tags
  solution = var.solution

  # Specify Network ACLs
  network_acls = {
    bypass         = "AzureServices"
    default_action = "Deny"
    ip_rules       = ["0.0.0.0/0"]

    virtual_network_subnet_ids = []
  }
  
    role_assignments = {
    # "Key Vault Secrets User"    = [module.pasview-be.app_user_assigned_identity_object_id, module.pasview-fe.app_user_assigned_identity_object_id ]
    "Contributor"               = []
    # "Key Vault Secrets Officer" = [azurerm_user_assigned_identity.agw_user_identity.principal_id]
    # "Key Vault Certificates Officer"                     = [azurerm_user_assigned_identity.agw_user_identity.principal_id]
    "Key Vault Reader"          = []
  }
  private_endpoint_subnet_id = lookup(module.vnet.vnet_subnets_name_id, "${var.environment}-${var.solution}-common-sn-${var.location_short_ae}-1")
}

resource "azurerm_key_vault_certificate" "agw_cert" {
  name         = "${var.environment}-${var.solution}-agw-ssl-cert-1"
  key_vault_id = module.app-kv.key_vault_id

  certificate {
    contents = filebase64("dev-centric-self-signed.pfx")
    password = "export"
  }
}