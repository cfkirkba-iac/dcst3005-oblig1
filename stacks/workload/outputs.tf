output "network_interface_id" {
  description = "ID-en til nettverkskortet som er opprettet i app-subnettet"
  value       = azurerm_network_interface.workload.id
}