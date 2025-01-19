resource "azurerm_resource_group" "rg-networking" {
  name     = var.rg-networking-name
  location = "eastus2"
}

resource "azurerm_resource_group" "rg-aks" {
  name     = var.rg-aks-name
  location = "eastus2"
}

resource "azurerm_resource_group" "rg-vms" {
  name     = var.rg-vms-name
  location = "eastus2"
}
