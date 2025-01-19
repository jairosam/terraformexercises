terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "stctfstate"
    storage_account_name = "stctfstatekub"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}

module "resource-groups" {
  source = "./resource-groups"
  rg-networking-name = var.rg-networking-name
  rg-aks-name = var.rg-aks-name
  rg-vms-name = var.rg-vms-name
}

module "virtual-network" {
  source  = "./networking"
  rg-name = module.resource-groups.rg-networking-id
  address-space = var.address-space
  subnet-vms-address = var.subnet-vms-address 
  subnet-aks-address = var.subnet-aks-address
  subnet-appgateway-address = var.subnet-appgateway-address 
}

module "aks-cluster" {
  source = "./cluster"
  snet-cluster = module.virtual-network.snet-cluster-id
  rg-aks-id = module.resource-groups.rg-aks-id
  vnet-id = module.virtual-network.vnet-id 
  depends_on = [
    module.virtual-network
  ]
}