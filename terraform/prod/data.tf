data "azurerm_private_dns_zone" "dns_zone" {
  provider            = azurerm.shared_networking
  name                = "azure.hanz.health.nz"
  resource_group_name = "sha-infra-dns-rg-ae-1"
}

data "azurerm_private_dns_zone" "kv_dns_zone" {
  provider            = azurerm.shared_networking
  name                = "privatelink.vaultcore.azure.net"
  resource_group_name = "sha-infra-dns-rg-ae-1"
}

data "azuread_group" "sql_admin_group" {
  display_name = "Azure_SEC_Role_App_Centric_Full"
  security_enabled = true
}
 
data "azurerm_key_vault_secret" "prod_cert_password" {
  name         = "azure-centric-prod-hanz-health-nz"
  key_vault_id = "/subscriptions/20afafa5-91a5-4cfe-8ce3-c2dcdcebf446/resourceGroups/prod-centric-tf-rg-ae-1/providers/Microsoft.KeyVault/vaults/prodcentrictfkvae1"
}
