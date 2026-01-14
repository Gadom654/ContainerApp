locals {
  vnet_name                               = "${var.prefix}-vnet"
  vnet_address_space                      = ["10.0.0.0/16"]
  private_subnet_1_name                   = "${var.prefix}-private-subnet-1"
  private_subnet_1_address_space          = ["10.0.0.0/24"]
  private_subnet_2_name                   = "${var.prefix}-private-subnet-2"
  private_subnet_2_address_space          = ["10.0.1.0/24"]
  public_subnet_1_name                    = "${var.prefix}-public-subnet-1"
  public_subnet_1_address_space           = ["10.0.2.0/24"]
  public_subnet_2_name                    = "${var.prefix}-public-subnet-2"
  public_subnet_2_address_space           = ["10.0.3.0/24"]
  private_subnets_outbound_access_enabled = false
  nat_gateway_name                        = "${var.prefix}-nat-gateway"
  nat_gateway_ip_name                     = "${var.prefix}-nat-gateway-pip"
  nat_gateway_ip_allocation_method        = "Static"
  nat_gateway_sku_standard                = "Standard"
  dns_vnet_link_name1                     = "${var.prefix}-dns-vnet-link1"
  dns_vnet_link_name2                     = "${var.prefix}-dns-vnet-link2"
  isregistration_enabled                  = false
  a_dns_record_name                       = "*"
  ttl_value                               = 300
}