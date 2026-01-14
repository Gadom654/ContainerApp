terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.57.0"
    }
    docker = {
      source = "kreuzwerker/docker"
      version = "3.6.2"
    }
  }
  backend "azurerm" {
    resource_group_name  = "tfstate"
    storage_account_name = "tfstate5146"
    container_name       = "ContainerAppTerraformState"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  resource_provider_registrations = "none"
  features {}
  use_cli             = false
  storage_use_azuread = true
}