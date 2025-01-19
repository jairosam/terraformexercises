# Resource group names for prod environment
rg-networking-name = "rg-prod-vnets"
rg-aks-name = "rg-prod-aks"
rg-vms-name = "rg-prod-vms"

# Address spaces for prod environment
address-space = ["10.40.0.0/16"]
subnet-vms-address = ["10.40.0.0/24"]
subnet-aks-address = ["10.40.1.0/24"]
subnet-appgateway-address = ["10.40.2.0/24"]