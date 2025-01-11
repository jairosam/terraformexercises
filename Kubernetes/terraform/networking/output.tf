output vnet-id {
	description = "vnet id for the cluster"
	value = azurerm_virtual_network.vnet-resource.id
}

output snet-cluster-id {
	description = "snet id for the cluster"
	value = azurerm_subnet.subnet-aks.id
}