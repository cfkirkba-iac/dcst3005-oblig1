output "subnet_ids" {
  description = "ID-ene til subnettene, indeksert med subnettnavn"
  value = {
    for key, subnet in azurerm_subnet.subnet :
    key => subnet.id
  }
}

output "vnet_id" {
  description = "ID-en til det virtuelle nettverket"
  value       = azurerm_virtual_network.vnet.id
}