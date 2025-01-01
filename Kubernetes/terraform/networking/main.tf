resource "azurerm_virtual_network" "vnet-resource" {
  name                = "vnet-resources"
  location            = "eastus2"
  resource_group_name = var.rg-name
  address_space       = ["10.10.0.0/16"]

  tags = {
    environment = "Test"
  }
}

resource "azurerm_subnet" "subnet-vms" {
  name                 = "subnet-vms"
  resource_group_name  = var.rg-name
  virtual_network_name = azurerm_virtual_network.vnet-resource.name
  address_prefixes     = ["10.10.0.0/24"]
}

resource "azurerm_subnet" "subnet-aks" {
  name                 = "subnet-aks"
  resource_group_name  = var.rg-name
  virtual_network_name = azurerm_virtual_network.vnet-resource.name
  address_prefixes     = ["10.10.1.0/24"]
}

resource "azurerm_subnet" "subnet-app-gateway" {
  name                 = "subnet-"
  resource_group_name  = var.rg-name
  virtual_network_name = azurerm_virtual_network.vnet-resource.name
  address_prefixes     = ["10.10.2.0/24"]
}
