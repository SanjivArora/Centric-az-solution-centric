data "azurerm_subscription" "current" {
}

data "azurerm_resource_group" "logging" {
  name = var.rg_name
}