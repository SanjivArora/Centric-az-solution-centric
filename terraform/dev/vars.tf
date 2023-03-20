variable "rg_name" {
  type        = string
  default     = "poc-replaceme-rg-ae-1"
  description = "poc"
}

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

# variable "SQL_ADMIN_PASS" {
#   description = "The SQL managed instance admin password"
#   type        = string
# }

variable "common_tags" {
  description = "Common tags applied to all the resources created in this module"
  type        = map(string)
  default     = {}
}

variable "environment" {
  description = "resources environment"
  default     = "dev"
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