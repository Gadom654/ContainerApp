##################################
###       Resource Group       ###
##################################
resource "azurerm_resource_group" "ContainerAppRG" {
  name     = local.resource_group_name
  location = var.location
  tags     = var.tags
}

##################################
###       Network Module      ###
##################################
module "network" {
  source              = "./modules/network"
  prefix              = var.prefix
  location            = var.location
  tags                = var.tags
  resource_group_name = local.resource_group_name
}