resource "azurerm_resource_group" "network_rg" {
  name     = "${var.environment}-${var.solution}-networking-${var.location_short_ae}-1"
  location = var.location
  tags = merge(
    local.common_tags, {
      Name = "${var.environment}-${var.solution}-networking-${var.location_short_ae}-1"
    }
  )
}

resource "azurerm_resource_group" "app_rg" {
  name     = "${var.environment}-${var.solution}-app-${var.location_short_ae}-1"
  location = var.location
  tags = merge(
    local.common_tags, {
      Name = "${var.environment}-${var.solution}-app-${var.location_short_ae}-1"
    }
  )
} 

resource "azurerm_resource_group" "sqlmi_rg" {
  name     = "${var.environment}-${var.solution}-sqlmi-${var.location_short_ae}-1"
  location = var.location
  tags = merge(
    local.common_tags, {
      Name = "${var.environment}-${var.solution}-sqlmi-${var.location_short_ae}-1"
    }
  )
}

resource "azurerm_resource_group" "common_rg" {
  name     = "${var.environment}-${var.solution}-common-${var.location_short_ae}-1"
  location = var.location
  tags = merge(
    local.common_tags, {
      Name = "${var.environment}-${var.solution}-common-${var.location_short_ae}-1"
    }
  )
}

resource "azurerm_resource_group" "logging_rg" {
  name     = "${var.environment}-${var.solution}-logging-${var.location_short_ae}-1"
  location = var.location
  tags = merge(
    local.common_tags, {
      Name = "${var.environment}-${var.solution}-logging-${var.location_short_ae}-1"
    }
  )
}

resource "azurerm_resource_group" "security_rg" {
  name     = "${var.environment}-${var.solution}-security-${var.location_short_ae}-1"
  location = var.location
  tags = merge(
    local.common_tags, {
      Name = "${var.environment}-${var.solution}-security-${var.location_short_ae}-1"
    }
  )
}

resource "azurerm_resource_group" "agw_rg" {
  name     = "${var.environment}-${var.solution}-agw-${var.location_short_ae}-1"
  location = var.location
  tags = merge(
    local.common_tags, {
      Name = "${var.environment}-${var.solution}-agw-${var.location_short_ae}-1"
    }
  )
}