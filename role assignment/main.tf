data "azurerm_role_definition" "acr_pull" {
  name = "AcrPull"
}

data "azurerm_container_registry" "acr" {
  for_each = var.aks_acr_pull
  name                = each.value.acrname
  resource_group_name = each.value.rgname
}

data "azurerm_kubernetes_cluster" "aks" {
  for_each = var.aks_acr_pull
  name                = each.value.clustername
  resource_group_name = each.value.rgname
}

resource "azurerm_role_assignment" "aks_acr_pull" {
  for_each = var.aks_acr_pull
  scope              = data.azurerm_container_registry.acr[each.key].id
  role_definition_id = data.azurerm_role_definition.acr_pull.id
  principal_id       = data.azurerm_kubernetes_cluster.aks[each.key].kubelet_identity[0].client_id
}
