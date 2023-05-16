locals {
  default_common_tags = {
    cost-centre     = "820-7237327-1864"
    owner           = "Centric@waitematadhb.govt.nz"
    business-entity = "NR"
    environment     = var.environment
    security-zone   = "Managed"
    role            = "Infrastructure"
    application     = var.solution
    app-tier        = "Shared"
    app-criticality = "Tier 1"
    support-team    = "Centric support team"
  }
  common_tags = merge(local.default_common_tags, var.common_tags)
}
