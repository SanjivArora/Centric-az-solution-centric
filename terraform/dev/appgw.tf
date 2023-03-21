#---------------------------------------------------------
# Front end public IP for App Gateway
#----------------------------------------------------------

resource "azurerm_public_ip" "agw-pip" {
  name                = "${var.environment}-${var.solution}-agw-pip-${var.location_short_ae}-1"
  resource_group_name = azurerm_resource_group.agw_rg.name
  location            = azurerm_resource_group.agw_rg.location
  allocation_method   = "Static"
  sku = "Standard"
  zones = [1, 2, 3]
  tags = merge(
    local.common_tags, {
      Name = format("%s", "${var.environment}-${var.solution}-agw-pip-${var.location_short_ae}-1")
    }
  )
}

#---------------------------------------------------------
# User Identity Creation for App Gateway
#----------------------------------------------------------

resource "azurerm_user_assigned_identity" "agw_user_identity" {
  location            = azurerm_resource_group.agw_rg.location
  resource_group_name = azurerm_resource_group.agw_rg.name
  name                = "${var.environment}-${var.solution}-agw-umi-${var.location_short_ae}-1"

  tags = merge(
    local.common_tags, {
      Name = format("%s", "${var.environment}-${var.solution}-agw-umi-${var.location_short_ae}-1")
    }
  )
}

#---------------------------------------------------------
# locals for App Gateway
#----------------------------------------------------------

locals {
  base_name = "${var.environment}-${var.solution}-agw-${var.location_short_ae}-1"
  pasview_frontend = module.pasview-fe.app_service_site_hostname
  pasview_backend = module.pasview-be.app_service_site_hostname
}

module "agw_v2" {
  source  = "../modules/app-gw"
# source = "git::https://dev.azure.com/Sharan-pocs/ha-sharan-test/_git/ha-terraform-module-appservice//modules/app-gw"

  appgw_name          = local.base_name
  location            = azurerm_resource_group.agw_rg.location
  resource_group_name = azurerm_resource_group.agw_rg.name
  appgw_pip_id = azurerm_public_ip.agw-pip.id
  subnet_id = lookup(module.vnet.vnet_subnets_name_id, "${var.environment}-${var.solution}-agw-sn-${var.location_short_ae}-1")
  appgw_private_ip = "10.166.209.10"
  user_assigned_identity_id = azurerm_user_assigned_identity.agw_user_identity.id

  appgw_backend_http_settings = [{
    name                  = "${local.base_name}-backhttpsettings"
    cookie_based_affinity = "Disabled"
    path                  = "/"
    port                  = 443
    protocol              = "Https"
    request_timeout       = 300
    probe_name            = "${local.base_name}-health-probe"
  }]

  appgw_backend_pools = [{
    name  = "${local.base_name}-backendpool-01"
    fqdns = [local.pasview_frontend]
  },
  {
    name = "${local.base_name}-backendpool-02"
    fqdns = [local.pasview_backend]
  }
  
  ]

  appgw_routings = [{
    name                       = "${local.base_name}-routing-https"
    rule_type                  = "PathBasedRouting"
    http_listener_name         = "${local.base_name}-listener-https"
    backend_address_pool_name  = "${local.base_name}-backendpool"
    backend_http_settings_name = "${local.base_name}-backhttpsettings"
    url_path_map_name = "${local.base_name}-pasview-url-path-map"
  }]

  # custom_frontend_ip_configuration_name = "${local.base_name}-frontipconfig"

  appgw_http_listeners = [{
    name                           = "${local.base_name}-listener-https"
    # frontend_ip_configuration_name = "${local.base_name}-frontipconfig"
    frontend_port_name             = "frontend-https-port"
    protocol                       = "Https"
    ssl_certificate_name           = azurerm_key_vault_certificate.agw_cert.name
    require_sni                    = false #tofix
    # host_name                      = local.pasview_frontend
  }]

  ssl_certificates_configs = [{
    name = azurerm_key_vault_certificate.agw_cert.name
    key_vault_secret_id = azurerm_key_vault_certificate.agw_cert.secret_id
  }]

  frontend_port_settings = [{
    name = "frontend-https-port"
    port = 443
  }]

  # appgw_redirect_configuration = [{
  #   name = "${local.base_name}-redirect"
  # }]

  appgw_url_path_map = [{
    name                               = "${local.base_name}-pasview-url-path-map"
    default_backend_http_settings_name = "${local.base_name}-backhttpsettings"
    default_backend_address_pool_name  = "${local.base_name}-backendpool-01"
    # default_rewrite_rule_set_name      = "${local.base_name}-example-rewrite-rule-set"
    # default_redirect_configuration_name = "${local.base_name}-redirect"
    path_rules = [
      {
        name                       = "${local.base_name}-frontend-url-path-rule"
        backend_address_pool_name  = "${local.base_name}-backendpool-01"
        backend_http_settings_name = "${local.base_name}-backhttpsettings"
        # rewrite_rule_set_name      = "${local.base_name}-example-rewrite-rule-set"
        paths                      = ["/PASView_WDHB/*"]
      },
      {
        name                       = "${local.base_name}-backend-url-path-rule"
        backend_address_pool_name  = "${local.base_name}-backendpool-02"
        backend_http_settings_name = "${local.base_name}-backhttpsettings"
        # rewrite_rule_set_name      = "${local.base_name}-example-rewrite-rule-set"
        paths                      = ["/PASView_WDHB_API/*"]
      }
    ]
  }]

  appgw_probes = [{
    name = "${local.base_name}-health-probe"
    # host = local.pasview_frontend
    port = 443
    interval = 30
    path = "/swagger/"
    protocol = "Https"
    timeout = 30
    pick_host_name_from_backend_http_settings = true

  }
  ]

  autoscaling_parameters = {
    min_capacity = 1
    max_capacity = 2
  }
  common_tags = local.common_tags
  depends_on = [azurerm_key_vault_certificate.agw_cert]
}



#---------------------------------------------------------
# Create A record in private DNS zone
#----------------------------------------------------------

resource "azurerm_private_dns_a_record" "agw_record" {
  provider = azurerm.shared_networking
  name                = "centric-${var.environment}"
  zone_name           = data.azurerm_private_dns_zone.dns_zone.name
  resource_group_name = data.azurerm_private_dns_zone.dns_zone.resource_group_name
  ttl                 = 300
  records             = ["10.166.209.10"] //IP address of Applictaion gateway front end.
}