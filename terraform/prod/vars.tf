variable "location" {
  type        = string
  default     = "australiaeast"
  description = "Resoucre Location"
}

variable "location_short_ae" {
  type        = string
  default     = "ae"
  description = "Short Resoucre Location name"
}

variable "application_insights_type" {
  type        = string
  default     = "web"
  description = "Specifies the type of Application Insights to create. Valid values are ios for iOS, java for Java web, MobileCenter for App Center, Node.JS for Node.js, other for General, phone for Windows Phone, store for Windows Store and web for ASP.NET. Please note these values are case sensitive; unmatched values are treated as ASP.NET by Azure. Changing this forces a new resource to be created. "
}

variable "retention_in_days" {
  type        = string
  default     = "90"
  description = "Specifies the retention period in days. Possible values are 30, 60, 90, 120, 180, 270, 365, 550 or 730. Defaults to 90"
}

variable "common_tags" {
  description = "Common tags applied to all the resources created in this module"
  type        = map(string)
  default     = {}
}

variable "environment" {
  description = "resources environment"
  default     = "prod"
  type        = string
}

variable "solution" {
  description = "Name of the solution"
  default     = "centric"
  type        = string
}

variable "gateway_address" {
  description = "Gateway IP address for the default route"
  type        = string
  default     = "10.166.5.4"
}

variable "zones" {
  description = "A collection of availability zones to spread the Application Gateway over. This option is only supported for v2 SKUs"
  type        = list(number)
  default     = [1, 2, 3]
}

variable "agw_frontend_ip" {
  description = "Application Gateway frontend static IP address"
  type        = string
  default     = "10.166.213.10"
}

variable "app_settings" {
  description = "Application settings for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#app_settings"
  type        = map(string)
  default     = {
    WEBSITE_TIME_ZONE = "New Zealand Standard Time"
    InstrumentationEngine_EXTENSION_VERSION = "disabled"
    minTlsVersion = "1.2"
    # WEBSITE_RUN_FROM_PACKAGE = "1"
    WEBSITE_ENABLE_SYNC_UPDATE_SITE = "true"
    WEBSITE_DNS_SERVER = "10.166.12.4"
    WEBSITE_ALT_DNS_SERVER = "10.166.12.5"
    APPINSIGHTS_PROFILERFEATURE_VERSION = "1.0.0"
    APPINSIGHTS_SNAPSHOTFEATURE_VERSION = "1.0.0"
    ApplicationInsightsAgent_EXTENSION_VERSION = "~3" 
    DiagnosticServices_EXTENSION_VERSION = "~3"
    SnapshotDebugger_EXTENSION_VERSION = "disabled"
    XDT_MicrosoftApplicationInsights_BaseExtensions = "disabled" 
    XDT_MicrosoftApplicationInsights_Java = "1"
    XDT_MicrosoftApplicationInsights_Mode = "recommended"
    XDT_MicrosoftApplicationInsights_NodeJS = "1"
    XDT_MicrosoftApplicationInsights_PreemptSdk = "disabled"
  }
}

variable "mailer_be_app_settings" {
  description = "Application settings for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#app_settings"
  type        = map(string)
  default     = {
    AppSettings__AppMode = "PROD"
  }
}

variable "authorized_ips" {
  description = "IPs restriction for App Service. See documentation https://www.terraform.io/docs/providers/azurerm/r/app_service.html#ip_restriction"
  type        = list(string)
  default     = ["20.227.10.42/32"]
}