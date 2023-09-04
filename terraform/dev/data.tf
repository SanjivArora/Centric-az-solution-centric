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
 
 data "azurerm_key_vault_secret" "dev_cert_password" {
  name         = "azure-centric-dev-hanz-health-nz"
  key_vault_id = "/subscriptions/05d495ea-a6f9-4407-b622-ee7d6efd3350/resourceGroups/dev-centric-tf-rg-ae-1/providers/Microsoft.KeyVault/vaults/devcentrickvae1"
}