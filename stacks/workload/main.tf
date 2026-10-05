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
  nic_name  = lower(format("nic-%s", local.base_name))

  tags = {
    environment = var.environment
    owner       = var.short_name
    managedby   = "terraform"
  }
}

data "terraform_remote_state" "network" {
  backend = "azurerm"

  config = merge(
    var.remote_state_config,
    {
      key = format("%s/network.tfstate", var.environment)
    }
  )
}

resource "azurerm_network_interface" "workload" {
  name                = local.nic_name
  location            = var.location
  resource_group_name = data.terraform_remote_state.network.outputs.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.terraform_remote_state.network.outputs.subnet_ids["app"]
    private_ip_address_allocation = "Dynamic"
  }

  tags = local.tags
}