data "azurerm_private_dns_zone" "dns_zone" {
  provider            = azurerm.shared_networking
  name                = "azure.hanz.health.nz"
  resource_group_name = "sha-infra-dns-rg-ae-1"
}

# data "azuread_group" "sql_admin_group" {
#   display_name = "Azure_SEC_Role_Project_Centric_Full"
#   security_enabled = true
# }
 