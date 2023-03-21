locals {
  default_common_tags = {
    cost-centre     = "12346"
    owner           = "michael.carr@healthalliance.co.nz"
    business-entity = "NR"
    environment     = var.environment
    security-zone   = "Manage"
    role            = "Infrastructure"
    application     = var.solution
    app-tier        = "Application"
    app-criticality = "Tier 2"
    support-team    = "Centric support team"
  }
  common_tags = merge(local.default_common_tags, var.common_tags)
}
