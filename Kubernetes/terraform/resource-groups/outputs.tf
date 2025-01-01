output "rg-vms-id" {
  description = "Id resource group vms"
  value       = azurerm_resource_group.rg-vms.id
}

output "rg-aks-id" {
  description = "Id resource group vms"
  value       = azurerm_resource_group.rg-aks.id	
}

output "rg-networking-id" {
  description = "Id resource group vms"
  value       = azurerm_resource_group.rg-networking.id
}