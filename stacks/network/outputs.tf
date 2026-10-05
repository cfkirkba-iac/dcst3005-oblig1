output "subnet_ids" {
  description = "Subnet-ID per subnettnavn, brukes av workload-stacken"
  value       = module.network.subnet_ids
}

output "vnet_id" {
  description = "ID-en til det virtuelle nettverket"
  value       = module.network.vnet_id
}

output "resource_group_name" {
  description = "Navnet på ressursgruppen, brukes av workload-stacken"
  value       = azurerm_resource_group.rg.name
}