output "rg-vms-id" {
  description = "Id resource group vms"
  value       = azurerm_resource_group.rg-vms.name
}

output "rg-aks-id" {
  description = "Id resource group vms"
  value       = azurerm_resource_group.rg-aks.name	
}

output "rg-networking-id" {
  description = "Id resource group vms"
  value       = azurerm_resource_group.rg-networking.name
}