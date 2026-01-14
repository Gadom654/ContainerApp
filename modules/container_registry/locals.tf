locals {
  container_registry_name = "${var.prefix}containerreg"
  container_registry_sku_standard = "Basic"
  container_registry_admin_enabled = true
}