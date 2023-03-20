locals {
  default_common_tags = {
    cost-centre     = "12346"
    owner           = "michael.carr@healthalliance.co.nz"
    business-entity = "WDHB"
    environment     = "poc"
    security-zone   = "Manage"
    role            = "Infrastructure"
    application     = "Centric"
    app-tier        = "Application"
    app-criticality = "Tier 2"
  }
  common_tags                             = merge(local.default_common_tags, var.common_tags)
}
