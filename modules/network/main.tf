##################################
###       Virtual Network      ###
################################## 
resource "azurerm_virtual_network" "ContainerAppVNet" {
  name                = local.vnet_name
  address_space       = local.vnet_address_space
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

##################################
###          Subnets           ###
##################################
resource "azurerm_subnet" "PrivateSubnet1" {
  name                            = local.private_subnet_1_name
  resource_group_name             = var.resource_group_name
  virtual_network_name            = azurerm_virtual_network.ContainerAppVNet.name
  address_prefixes                = local.private_subnet_1_address_space
  default_outbound_access_enabled = local.private_subnets_outbound_access_enabled
}
resource "azurerm_subnet" "PrivateSubnet2" {
  name                            = local.private_subnet_2_name
  resource_group_name             = var.resource_group_name
  virtual_network_name            = azurerm_virtual_network.ContainerAppVNet.name
  address_prefixes                = local.private_subnet_2_address_space
  default_outbound_access_enabled = local.private_subnets_outbound_access_enabled
}
resource "azurerm_subnet" "PublicSubnet1" {
  name                 = local.public_subnet_1_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.ContainerAppVNet.name
  address_prefixes     = local.public_subnet_1_address_space
}
resource "azurerm_subnet" "PublicSubnet2" {
  name                 = local.public_subnet_2_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.ContainerAppVNet.name
  address_prefixes     = local.public_subnet_2_address_space
}

##################################
###         NAT Gateway        ###
##################################
resource "azurerm_public_ip" "PrivateSubnetsNATPublicIP" {
  name                = local.nat_gateway_ip_name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = local.nat_gateway_ip_allocation_method
  sku                 = local.nat_gateway_sku_standard
  tags                = var.tags

}
resource "azurerm_nat_gateway" "PrivateSubnetsNATGateway" {
  name                = local.nat_gateway_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}
resource "azurerm_nat_gateway_public_ip_association" "NATGatewayPublicIPAssociation" {
  nat_gateway_id       = azurerm_nat_gateway.PrivateSubnetsNATGateway.id
  public_ip_address_id = azurerm_public_ip.PrivateSubnetsNATPublicIP.id
}
resource "azurerm_subnet_nat_gateway_association" "PrivateSubnet1NATAssociation" {
  subnet_id      = azurerm_subnet.PrivateSubnet1.id
  nat_gateway_id = azurerm_nat_gateway.PrivateSubnetsNATGateway.id
}
resource "azurerm_subnet_nat_gateway_association" "PrivateSubnet2NATAssociation" {
  subnet_id      = azurerm_subnet.PrivateSubnet2.id
  nat_gateway_id = azurerm_nat_gateway.PrivateSubnetsNATGateway.id
}
##################################
###      Private DNS Zones     ###
##################################
resource "azurerm_private_dns_zone" "PrivateDNSZone1" {
  name                = var.app_1_domain
  resource_group_name = var.resource_group_name
  tags                = var.tags
}
resource "azurerm_private_dns_zone" "PrivateDNSZone2" {
  name                = var.app_2_domain
  resource_group_name = var.resource_group_name
  tags                = var.tags
}
##################################
###   Private DNS Zone Links   ###
##################################
resource "azurerm_private_dns_zone_virtual_network_link" "DNSZone1VNetLink" {
  name                  = local.dns_vnet_link_name1
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.PrivateDNSZone1.name
  virtual_network_id    = azurerm_virtual_network.ContainerAppVNet.id
  registration_enabled  = local.isregistration_enabled
  tags                  = var.tags
}
resource "azurerm_private_dns_zone_virtual_network_link" "DNSZone2VNetLink" {
  name                  = local.dns_vnet_link_name2
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.PrivateDNSZone2.name
  virtual_network_id    = azurerm_virtual_network.ContainerAppVNet.id
  registration_enabled  = local.isregistration_enabled
  tags                  = var.tags
}
################################
###       DNS Records        ###
################################
resource "azurerm_private_dns_a_record" "App1ARecord" {
  name                = local.a_dns_record_name
  zone_name           = azurerm_private_dns_zone.PrivateDNSZone1.name
  resource_group_name = var.resource_group_name
  ttl                 = local.ttl_value
  records             = [var.container_app_env_1_ip]
}
resource "azurerm_private_dns_a_record" "App2ARecord" {
  name                = local.a_dns_record_name
  zone_name           = azurerm_private_dns_zone.PrivateDNSZone2.name
  resource_group_name = var.resource_group_name
  ttl                 = local.ttl_value
  records             = [var.container_app_env_2_ip]
}
##################################
###  Security Groups & Rules   ###
##################################
