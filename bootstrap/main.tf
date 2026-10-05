terraform {
  required_version = ">= 1.16.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 5.4"
    }

    random = {
      source = "hashicorp/random"
    }
  }
}

provider "azurerm" {
  features {}

  use_cli             = true
  storage_use_azuread = true

  resource_providers_to_register = [
    "Microsoft.Storage"
  ]
}

data "azurerm_client_config" "current" {}

resource "random_string" "suffix" {
  length  = 6
  lower   = true
  upper   = false
  numeric = true
  special = false
}

locals {
  tags = {
    keep      = "true"
    purpose   = "terraform-backend"
    owner     = var.short_name
    managedby = "terraform"
  }
}

resource "azurerm_resource_group" "rg" {
  name     = lower(format("rg-tfstate-%s", var.short_name))
  location = var.location
  tags     = local.tags
}

resource "azurerm_storage_account" "sa" {
  name                     = lower(format("sttf%s%s", var.short_name, random_string.suffix.result))
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  shared_access_key_enabled       = false
  default_to_oauth_authentication = true
  allow_nested_items_to_be_public = false
  min_tls_version                 = "TLS1_2"

  blob_properties {
    versioning_enabled = true

    delete_retention_policy {
      days = 7
    }

    container_delete_retention_policy {
      days = 7
    }
  }

  tags = local.tags
}

resource "azurerm_role_assignment" "blob_contributor_current_user" {
  scope                = azurerm_storage_account.sa.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = data.azurerm_client_config.current.object_id
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_id    = azurerm_storage_account.sa.id
  container_access_type = "private"

  depends_on = [
    azurerm_role_assignment.blob_contributor_current_user
  ]
}