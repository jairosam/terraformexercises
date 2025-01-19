# resource group names 
variable "rg-networking-name" {
  type = string
}

variable "rg-aks-name" {
  type = string
}

variable "rg-vms-name" {
  type = string
}

# address spaces
variable "address-space" {
  type = list
  default = ["10.10.0.0/16"]
}

variable "subnet-vms-address" {
  type = list
  default = ["10.10.0.0/24"]
}

variable "subnet-aks-address" {
  type = list
  default = ["10.10.1.0/24"]
}

variable "subnet-appgateway-address" {
  type = list
  default = ["10.10.2.0/24"]
}
