##################################
###     Container App Envs     ###
##################################
resource "azurerm_container_app_environment" "PrivateContainerAppEnv1" {
  name                = local.container_app_env_name1
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  public_network_access = local.public_network_access_disabled

  logs_destination           = local.container_app_logs_destination
  log_analytics_workspace_id = var.container_law_id
  infrastructure_subnet_id   = var.private_subnet_1_id
}
resource "azurerm_container_app_environment" "PrivateContainerAppEnv2" {
  name                = local.container_app_env_name2
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags

  public_network_access = local.public_network_access_disabled

  logs_destination           = local.container_app_logs_destination
  log_analytics_workspace_id = var.container_law_id
  infrastructure_subnet_id   = var.private_subnet_1_id
}
##################################
###     Container Apps         ###
##################################
resource "azurerm_container_app" "PrivateContainerApp1" {
  name                         = local.container_app_name1
  resource_group_name          = var.resource_group_name
  tags                         = var.tags
  container_app_environment_id = azurerm_container_app_environment.PrivateContainerAppEnv1.id

  revision_mode = local.container_revision_mode

  template {
    container {
      name   = local.container_name1
      image  = var.container_image_url
      cpu    = local.container_cpu
      memory = local.container_memory
    }
    min_replicas = local.min_replicas
    max_replicas = local.max_replicas
  }
  ingress {
    allow_insecure_connections = local.ingress_allow_insecure_connections
    external_enabled           = local.isexternal_enabled
    target_port                = local.container_port
    transport                  = local.transport_protocol
    traffic_weight {
      percentage      = local.traffic_percentage
      latest_revision = local.traffic_latest_revision
    }
  }
}
resource "azurerm_container_app" "PrivateContainerApp2" {
  name                         = local.container_app_name2
  resource_group_name          = var.resource_group_name
  tags                         = var.tags
  container_app_environment_id = azurerm_container_app_environment.PrivateContainerAppEnv2.id

  revision_mode = local.container_revision_mode

  template {
    container {
      name   = local.container_name2
      image  = var.container_image_url
      cpu    = local.container_cpu
      memory = local.container_memory
    }
    min_replicas = local.min_replicas
    max_replicas = local.max_replicas
  }
  ingress {
    allow_insecure_connections = local.ingress_allow_insecure_connections
    external_enabled           = local.isexternal_enabled
    target_port                = local.container_port
    transport                  = local.transport_protocol
    traffic_weight {
      percentage      = local.traffic_percentage
      latest_revision = local.traffic_latest_revision
    }
  }
}