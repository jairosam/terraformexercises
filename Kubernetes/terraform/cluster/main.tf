resource "azurerm_user_assigned_identity" "aks-identity" {
  name                = "aks-cluster-identity"
  resource_group_name = var.rg-aks-id
  location            = "eastus2"
}

resource "azurerm_kubernetes_cluster" "aks-cluster" {
  name                       = "aks-cluster"
  location                   = "eastus2"
  resource_group_name        = var.rg-aks-id
  dns_prefix_private_cluster = "aks-private-k8s"
  private_cluster_enabled    = true

  default_node_pool {
    name    = "masterpool"
    vm_size = ""
  }

  identity {
    type         = "UserAssigned"
    identity_ids = tolist([azurerm_user_assigned_identity.aks-identity.id])
  }



}