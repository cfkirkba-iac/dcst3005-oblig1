terraform {
  required_version = ">= 1.16.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 5.4"
    }
  }

  backend "azurerm" {}
}

provider "azurerm" {
  features {}
}

locals {
  base_name = lower(format("oblig1-%s-%s", var.environment, var.short_name))
  rg_name   = lower(format("rg-%s", local.base_name))

  subnets = {
    web  = 0
    app  = 1
    data = 2
  }

  tags = {
    environment = var.environment
    owner       = var.short_name
    managedby   = "terraform"
  }
}

resource "azurerm_resource_group" "rg" {
  name     = local.rg_name
  location = var.location
  tags     = local.tags
}

module "network" {
  source = "../../modules/network"

  rg_name       = azurerm_resource_group.rg.name
  location      = azurerm_resource_group.rg.location
  base_name     = local.base_name
  address_space = var.address_space
  subnets       = local.subnets
  tags          = local.tags
}