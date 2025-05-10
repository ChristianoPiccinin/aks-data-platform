
output "resource_group_name" {
  value = azurerm_resource_group.rg.name
}

output "aks_name" {
  value = azurerm_kubernetes_cluster.aks.name
}

output "adls_name" {
  value = azurerm_storage_account.adls.name
}

output "acr_name" {
  value = azurerm_container_registry.acr.name
}
