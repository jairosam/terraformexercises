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
  name                 = "subnet-app-gateway"
  resource_group_name  = var.rg-name
  virtual_network_name = azurerm_virtual_network.vnet-resource.name
  address_prefixes     = ["10.10.2.0/24"]
}

resource "azurerm_public_ip" "ip-app-gateway" {
  name                = "publicIP-gateway"
  resource_group_name = var.rg-name
  location            = "eastus2"
  allocation_method   = "Static"
}

resource "azurerm_application_gateway" "app-gateway-cluster" {
  
  name                = "app-gateway-cluster"
  resource_group_name = var.rg-name
  location            = "eastus2"

  sku {
    name     = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 1
  }

  gateway_ip_configuration {
    name      = "my-gateway-subnet"
    subnet_id = azurerm_subnet.subnet-app-gateway.id
  }

  frontend_port {
    name = "frontend_port"
    port = 80
  }

  frontend_ip_configuration {
    name                 = "public-frontend-ip"
    public_ip_address_id = azurerm_public_ip.ip-app-gateway.id
  }

  frontend_ip_configuration {
    name                          = "private-frontend-ip"
    subnet_id                     = azurerm_subnet.subnet-app-gateway.id
    private_ip_address_allocation = "Dynamic"
  }

  backend_address_pool {
    name = "backend-cluster"
  }

  backend_http_settings {
    name                  = "http-setting-cluster"
    cookie_based_affinity = "Disabled"
    path                  = "/"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }

  http_listener {
    name                           = "http-listener-cluster"
    frontend_ip_configuration_name = "public-frontend-ip"
    frontend_port_name             = "frontend-port"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "routing-rule-1"
    priority                   = 10
    rule_type                  = "Basic"
    http_listener_name         = "http-listener-cluster"
    backend_address_pool_name  = "backend-cluster"
    backend_http_settings_name = "http-setting-cluster"
  }

}
