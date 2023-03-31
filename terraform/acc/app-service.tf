module "pasview-be" {
  # source = "../modules/azure-app-service"
  source = "git::https://dev.azure.com/NorthernRegion-dev/az-terraform-modules/_git/tf-module-windows-web-app"

  create_resource_group          = false
  environment = var.environment
  resource_group_name            = azurerm_resource_group.app_rg.name
  location                       = azurerm_resource_group.app_rg.location
  create_log_analytics_workspace = true
  log_analytics_workspace_name   = "${var.environment}-${var.solution}-law-ae-1"
  log_analytics_workspace_sku    = "PerGB2018"
  log_analytics_data_retention   = 30
  create_service_plan            = true
  service_plan_name              = "${var.environment}-${var.solution}-asp-ae-1"
  os_type                        = "Windows"
  service_plan_sku_name          = "B1"
  create_application_insights    = true
  application_insights_name      = "${var.environment}-${var.solution}-appi-ae-1"
  application_insights_type      = "web"
  application_insights_enabled   = true
  solution                   = "centric"
  service_name                   = "pasview-be"
  site_config = {
    minimum_tls_version = "1.2"
    always_on           = "true"
    application_stack = {
      current_stack  = "dotnet"
      dotnet_version = "v4.0"
    }
  }
  app_settings = {
    WEBSITE_HEALTHCHECK_MAXPINGFAILURES     = "10"
    InstrumentationEngine_EXTENSION_VERSION = "disabled"
    minTlsVersion = "1.2"
  }
  app_service_vnet_integration_subnet_id = lookup(module.vnet.vnet_subnets_name_id, "${var.environment}-${var.solution}-app-sn-${var.location_short_ae}-1")
  private_endpoint_subnet_id = lookup(module.vnet.vnet_subnets_name_id, "${var.environment}-${var.solution}-common-sn-${var.location_short_ae}-1")
  common_tags = local.common_tags
}

# module "pasview-fe" {
#   # source = "../modules/azure-app-service"
# source = "git::https://dev.azure.com/NorthernRegion-dev/az-terraform-modules/_git/tf-module-windows-web-app"

#   create_resource_group          = false
#   environment = var.environment
#   resource_group_name            = azurerm_resource_group.app_rg.name
#   location                       = azurerm_resource_group.app_rg.location
#   create_log_analytics_workspace = false
#   log_analytics_workspace_name   = "${var.environment}-${var.solution}-law-ae-1"
#   log_analytics_workspace_sku    = "PerGB2018"
#   log_analytics_data_retention   = 30
#   create_service_plan            = false
#   service_plan_name              = "${var.environment}-${var.solution}-asp-ae-1"
#   os_type                        = "Windows"
#   service_plan_sku_name          = "B1"
#   create_application_insights    = false
#   application_insights_name      = "${var.environment}-${var.solution}-appi-ae-1"
#   application_insights_type      = "web"
#   application_insights_enabled   = false
#   solution                   = "centric"
#   service_name                   = "pasview-fe"
#   site_config = {
#     minimum_tls_version = "1.2"
#     always_on           = "true"

#     application_stack = {
#       current_stack  = "node"
#       node_version = "~14"
#     }

#   }
#   app_settings = {
#     WEBSITE_HEALTHCHECK_MAXPINGFAILURES     = "10"
#     InstrumentationEngine_EXTENSION_VERSION = "disabled"
#     minTlsVersion = "1.2"
#   }
#   app_service_vnet_integration_subnet_id = lookup(module.vnet.vnet_subnets_name_id, "${var.environment}-${var.solution}-app-sn-${var.location_short_ae}-1")
#   private_endpoint_subnet_id = lookup(module.vnet.vnet_subnets_name_id, "${var.environment}-${var.solution}-common-sn-${var.location_short_ae}-1")
#   common_tags = local.common_tags
# }

# module "mailer-be" {
#   # source = "../modules/azure-app-service"
# source = "git::https://dev.azure.com/NorthernRegion-dev/az-terraform-modules/_git/tf-module-windows-web-app"

#   create_resource_group          = false
#   environment = var.environment
#   resource_group_name            = azurerm_resource_group.app_rg.name
#   location                       = azurerm_resource_group.app_rg.location
#   create_log_analytics_workspace = false
#   log_analytics_workspace_name   = "${var.environment}-${var.solution}-law-ae-1"
#   log_analytics_workspace_sku    = "PerGB2018"
#   log_analytics_data_retention   = 30
#   create_service_plan            = false
#   service_plan_name              = "${var.environment}-${var.solution}-asp-ae-1"
#   os_type                        = "Windows"
#   service_plan_sku_name          = "B1"
#   create_application_insights    = false
#   application_insights_name      = "${var.environment}-${var.solution}-appi-ae-1"
#   application_insights_type      = "web"
#   application_insights_enabled   = false
#   solution                   = "centric"
#   service_name                   = "mailer-be"
#   site_config = {
#     minimum_tls_version = "1.2"
#     always_on           = "true"

#     application_stack = {
#       current_stack  = "dotnet"
#       dotnet_version = "v4.0"
#     }

#   }
#   app_settings = {
#     WEBSITE_HEALTHCHECK_MAXPINGFAILURES     = "10"
#     InstrumentationEngine_EXTENSION_VERSION = "disabled"
#     minTlsVersion = "1.2"
#   }
#   app_service_vnet_integration_subnet_id = lookup(module.vnet.vnet_subnets_name_id, "${var.environment}-${var.solution}-app-sn-${var.location_short_ae}-1")
#   private_endpoint_subnet_id = lookup(module.vnet.vnet_subnets_name_id, "${var.environment}-${var.solution}-common-sn-${var.location_short_ae}-1")
#   common_tags = local.common_tags
# }

# module "mailer-fe" {
#   # source = "../modules/azure-app-service"
# source = "git::https://dev.azure.com/NorthernRegion-dev/az-terraform-modules/_git/tf-module-windows-web-app"

#   create_resource_group          = false
#   environment = var.environment
#   resource_group_name            = azurerm_resource_group.app_rg.name
#   location                       = azurerm_resource_group.app_rg.location
#   create_log_analytics_workspace = false
#   log_analytics_workspace_name   = "${var.environment}-${var.solution}-law-ae-1"
#   log_analytics_workspace_sku    = "PerGB2018"
#   log_analytics_data_retention   = 30
#   create_service_plan            = false
#   service_plan_name              = "${var.environment}-${var.solution}-asp-ae-1"
#   os_type                        = "Windows"
#   service_plan_sku_name          = "B1"
#   create_application_insights    = false
#   application_insights_name      = "${var.environment}-${var.solution}-appi-ae-1"
#   application_insights_type      = "web"
#   application_insights_enabled   = false
#   solution                   = "centric"
#   service_name                   = "mailer-fe"
#   site_config = {
#     minimum_tls_version = "1.2"
#     always_on           = "true"

#     application_stack = {
#       current_stack  = "node"
#       node_version = "~14"
#     }

#   }
#   app_settings = {
#     WEBSITE_HEALTHCHECK_MAXPINGFAILURES     = "10"
#     InstrumentationEngine_EXTENSION_VERSION = "disabled"
#     minTlsVersion = "1.2"
#   }
#   app_service_vnet_integration_subnet_id = lookup(module.vnet.vnet_subnets_name_id, "${var.environment}-${var.solution}-app-sn-${var.location_short_ae}-1")
#   private_endpoint_subnet_id = lookup(module.vnet.vnet_subnets_name_id, "${var.environment}-${var.solution}-common-sn-${var.location_short_ae}-1")
#   common_tags = local.common_tags
# }