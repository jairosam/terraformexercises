resource "azurerm_user_assigned_identity" "aks-identity" {
  name                = "aks-cluster-identity"
  resource_group_name = "${var.rg-aks-id}"
  location            = "eastus2"
}

resource "azurerm_private_dns_zone" "cluster_dns" {
  resource_group_name = "${var.rg-aks-id}"
  name                = "private.eastus2.azmk8s.io"
}

resource "azurerm_role_assignment" "dns_role_contributor" {
  scope                = azurerm_private_dns_zone.cluster_dns.id
  role_definition_name = "Private DNS Zone Contributor"
  principal_id         = azurerm_user_assigned_identity.aks-identity.principal_id
}

resource "azurerm_role_assignment" "virtual_network_contributor" {
  scope = var.vnet-id
  role_definition_name = "Network Contributor"
  principal_id = azurerm_user_assigned_identity.aks-identity.principal_id
}

resource "azurerm_kubernetes_cluster" "aks-cluster" {
  name                       = "aks-cluster"
  location                   = "eastus2"
  resource_group_name        = "${var.rg-aks-id}"
  dns_prefix_private_cluster = "aks-private-k8s"
  private_cluster_enabled    = true
  sku_tier                   = "Free"
  private_dns_zone_id        = azurerm_private_dns_zone.cluster_dns.id

  default_node_pool {
    name           = "masterpool"
    vm_size        = "Standard_D2s_v3"
    node_count     = 2
    vnet_subnet_id = var.snet-cluster
  }

  network_profile {
    network_plugin      = "azure"
    network_policy      = "azure"
    network_plugin_mode = "overlay"
    pod_cidr            = "10.100.0.0/16"
    service_cidr        = "10.110.0.0/16"
    dns_service_ip = "10.110.0.10"
  }

  identity {
    type         = "UserAssigned"
    identity_ids = tolist([azurerm_user_assigned_identity.aks-identity.id])
  }

  depends_on = [
    azurerm_role_assignment.dns_role_contributor,
  ]

}