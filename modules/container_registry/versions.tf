terraform {
  required_version = ">= 1.5.0"
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
}