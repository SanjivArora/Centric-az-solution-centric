#---------------------------------------------------------
# User Identity Creation for App Gateway
#----------------------------------------------------------

resource "azurerm_user_assigned_identity" "agw_user_identity" {
  location            = azurerm_resource_group.agw_rg.location
  resource_group_name = azurerm_resource_group.agw_rg.name
  name                = "${var.environment}-${var.solution}-agw-umi-${var.location_short_ae}-1"

  tags = merge(
    var.common_tags, {
      Name = format("%s", "${var.environment}-${var.solution}-agw-umi-${var.location_short_ae}-1")
    }
  )
}

#---------------------------------------------------------
# User Identity Creation for pasview frontend
#----------------------------------------------------------

resource "azurerm_user_assigned_identity" "pasview_fe_identity" {
  location            = azurerm_resource_group.app_rg.location
  resource_group_name = azurerm_resource_group.app_rg.name
  name                = "${var.environment}-${var.solution}-pasview-fe-umi-${var.location_short_ae}-1"

  tags = merge(
    var.common_tags, {
      Name = format("%s", "${var.environment}-${var.solution}-pasview-fe-umi-${var.location_short_ae}-1")
    }
  )
}

#---------------------------------------------------------
# User Identity Creation for pasview backend
#----------------------------------------------------------

resource "azurerm_user_assigned_identity" "pasview_be_identity" {
  location            = azurerm_resource_group.app_rg.location
  resource_group_name = azurerm_resource_group.app_rg.name
  name                = "${var.environment}-${var.solution}-pasview-be-umi-${var.location_short_ae}-1"

  tags = merge(
    var.common_tags, {
      Name = format("%s", "${var.environment}-${var.solution}-pasview-be-umi-${var.location_short_ae}-1")
    }
  )
}