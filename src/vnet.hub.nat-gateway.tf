locals {
  nat_gateway = {
    zones = ["1", "2", "3"]
  }
}

resource "azurerm_nat_gateway" "hub" {
  name                    = "hub-nat-gateway"
  location                = azurerm_resource_group.default.location
  resource_group_name     = azurerm_resource_group.default.name
  sku_name                = "Standard"
  idle_timeout_in_minutes = 30
  zones                   = local.nat_gateway.zones
}

resource "azurerm_public_ip_prefix" "hub_nat_gateway" {
  name                = "hub-nat-gateway"
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
  prefix_length       = 28 # 28 = 16 addresses
  zones               = local.nat_gateway.zones
}

resource "azurerm_nat_gateway_public_ip_prefix_association" "hub_nat_gateway" {
  nat_gateway_id      = azurerm_nat_gateway.hub.id
  public_ip_prefix_id = azurerm_public_ip_prefix.hub_nat_gateway.id
}

resource "azurerm_subnet_nat_gateway_association" "hub_nat_gateway_core_workloads" {
  subnet_id      = azurerm_subnet.spoke_core_workloads.id
  nat_gateway_id = azurerm_nat_gateway.hub.id
}

resource "azurerm_subnet_nat_gateway_association" "hub_nat_gateway_spoke_core_container_app_environment" {
  subnet_id      = azurerm_subnet.spoke_core_container_app_environment.id
  nat_gateway_id = azurerm_nat_gateway.hub.id
}
