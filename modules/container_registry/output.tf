output "container_image_url" {
  value = "${azurerm_container_registry.ContainerRegistry.login_server}/${local.image_names[0]}"
}