resource "azurerm_resource_group" "rg-networking" {
  name     = "rg-vnets"
  location = "eastus2"
}

resource "azurerm_resource_group" "rg-aks" {
  name     = "rg-vnets"
  location = "eastus2"
}

resource "azurerm_resource_group" "rg-vms" {
  name     = "rg-vms"
  location = "eastus2"
}
