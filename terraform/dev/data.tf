data "azurerm_private_dns_zone" "dns_zone" {
  provider = azurerm.shared_networking
  name                = "azure.hanz.health.nz"
  resource_group_name = "sha-infra-dns-rg-ae-1"
}
