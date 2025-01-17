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
}

module "virtual-network" {
  source  = "./networking"
  rg-name = module.resource-groups.rg-networking-id
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