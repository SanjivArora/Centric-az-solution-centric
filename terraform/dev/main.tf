resource "azurerm_resource_group" "network_rg" {
  name     = "${var.environment}-${var.solution}-networking-ae-1"
  location = var.location
}

resource "azurerm_resource_group" "app_rg" {
  name     = "${var.environment}-${var.solution}-app-ae-1"
  location = var.location
}

resource "azurerm_resource_group" "data_rg" {
  name     = "${var.environment}-${var.solution}-data-ae-1"
  location = var.location
}

resource "azurerm_resource_group" "sqlmi_rg" {
  name     = "${var.environment}-${var.solution}-sqlmi-ae-1"
  location = var.location
}

resource "azurerm_resource_group" "common_rg" {
  name     = "${var.environment}-${var.solution}-common-ae-1"
  location = var.location
}

resource "azurerm_resource_group" "logging_rg" {
  name     = "${var.environment}-${var.solution}-logging-ae-1"
  location = var.location
}

resource "azurerm_resource_group" "security_rg" {
  name     = "${var.environment}-${var.solution}-security-ae-1"
  location = var.location
}

resource "azurerm_resource_group" "agw_rg" {
  name     = "${var.environment}-${var.solution}-agw-ae-1"
  location = var.location
}