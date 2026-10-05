output "backend_resource_group" {
  description = "Navnet på ressursgruppen som inneholder Terraform-backenden"
  value       = azurerm_resource_group.rg.name
}

output "backend_storage_account" {
  description = "Navnet på storage account-et som lagrer Terraform-state"
  value       = azurerm_storage_account.sa.name
}

output "backend_container" {
  description = "Navnet på containeren som lagrer Terraform-state"
  value       = azurerm_storage_container.tfstate.name
}