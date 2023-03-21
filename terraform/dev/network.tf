module "vnet" {
  source              = "../modules/network"
  resource_group_name = azurerm_resource_group.network_rg.name
  address_space       = ["10.166.208.0/23"]
  subnet_prefixes = [
    "10.166.208.0/26",
    "10.166.208.128/26",
    "10.166.209.0/26",
    "10.166.209.128/26"
  ]
  subnet_names = [
    "${var.environment}-${var.solution}-app-sn-${var.location_short_ae}-1",
    "${var.environment}-${var.solution}-sqlmi-sn-${var.location_short_ae}-1",
    "${var.environment}-${var.solution}-agw-sn-${var.location_short_ae}-1",
    "${var.environment}-${var.solution}-common-sn-${var.location_short_ae}-1"
  ]
  vnet_location     = azurerm_resource_group.network_rg.location
  common_tags       = local.common_tags
  location_short_ae = var.location_short_ae
  environment       = var.environment
  solution          = var.solution
  dns_servers       = ["10.166.12.4", "10.166.12.5", "10.167.12.4", "10.167.12.5"]

  subnet_delegation = {
    "${var.environment}-${var.solution}-app-sn-${var.location_short_ae}-1" = {
      "Microsoft.Web.serverFarms" = {
        service_name = "Microsoft.Web/serverFarms"
        service_actions = [
          "Microsoft.Network/virtualNetworks/subnets/action"
        ]
      }
    },
    "${var.environment}-${var.solution}-sqlmi-sn-${var.location_short_ae}-1" = {
      "Microsoft.Sql/managedInstances" = {
        service_name = "Microsoft.Sql/managedInstances"
        service_actions = [
          "Microsoft.Network/virtualNetworks/subnets/join/action",
          "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
        "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"]
      }
    }
  }

  route_tables_ids = {
    "${var.environment}-${var.solution}-app-sn-${var.location_short_ae}-1" = azurerm_route_table.this_table.id
    "${var.environment}-${var.solution}-agw-sn-${var.location_short_ae}-1" = azurerm_route_table.this_table.id
  }
}

resource "azurerm_route_table" "this_table" {
  location            = azurerm_resource_group.network_rg.location
  name                = "${var.environment}-${var.solution}-rt-${var.location_short_ae}-1"
  resource_group_name = azurerm_resource_group.network_rg.name

  route {
    name                   = "Default"
    address_prefix         = "10.0.0.0/8"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = var.gateway_address
  }
  tags = merge(
    local.common_tags,
    {
      Name        = "${var.environment}-${var.solution}-rt-${var.location_short_ae}-1"
      description = "Default route table for app subnets in Australia East region"
    }
  )
}

# resource "azurerm_route_table" "rt" {
#   name                = "poc-replaceme-rt-ae-1"
#   location            = azurerm_resource_group.network_rg.location
#   resource_group_name = azurerm_resource_group.network_rg.name

#   route {
#     name                   = "Default"
#     address_prefix         = "0.0.0.0/0"
#     next_hop_type          = "Internet"
#     # next_hop_in_ip_address = "10.10.1.1"
#   }
# }

# resource "azurerm_subnet_route_table_association" "app_gw" {
#   subnet_id      = azurerm_subnet.app_gw.id
#   route_table_id = azurerm_route_table.rt.id
# }
