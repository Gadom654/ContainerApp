##################################
###       Resource Group       ###
##################################
resource "azurerm_resource_group" "ContainerAppRG" {
  name     = local.resource_group_name
  location = var.location
  tags     = var.tags
}

##################################
###       Network Module       ###
##################################
module "network" {
  source                 = "./modules/network"
  prefix                 = var.prefix
  location               = var.location
  tags                   = var.tags
  resource_group_name    = local.resource_group_name
  app_1_domain           = module.container_app.app_1_domain
  app_2_domain           = module.container_app.app_2_domain
  container_app_env_1_ip = module.container_app.container_app_env_1_ip
  container_app_env_2_ip = module.container_app.container_app_env_2_ip
}
##################################
### Container Registry Module  ###
##################################
module "container_registry" {
  source              = "./modules/container_registry"
  prefix              = var.prefix
  location            = var.location
  tags                = var.tags
  resource_group_name = local.resource_group_name
  github_access_token = var.github_access_token
}
##################################
### Log Analytics Workspace    ###
################################## 
module "log_analytics" {
  source              = "./modules/monitoring"
  prefix              = var.prefix
  location            = var.location
  tags                = var.tags
  resource_group_name = local.resource_group_name
}
##################################
###   Container App Module    ###
##################################
module "container_app" {
  source              = "./modules/container_app"
  prefix              = var.prefix
  location            = var.location
  tags                = var.tags
  resource_group_name = local.resource_group_name
  container_law_id    = module.log_analytics.Container_LAW_id
  private_subnet_1_id = module.network.private_subnet_1_id
  private_subnet_2_id = module.network.private_subnet_2_id
  container_image_url = module.container_registry.container_image_url
}
##################################
### Application Gateway Module ###
##################################
module "app_gateway" {
  source              = "./modules/app_gateway"
  prefix              = var.prefix
  location            = var.location
  tags                = var.tags
  resource_group_name = local.resource_group_name
  public_subnet_1_id  = module.network.public_subnet_1_id
  public_subnet_2_id  = module.network.public_subnet_2_id
  app_1_url           = module.container_app.app_1_domain
  app_2_url           = module.container_app.app_2_domain
}