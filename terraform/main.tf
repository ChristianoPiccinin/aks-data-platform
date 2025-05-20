# RG para desenvolvimento
resource "azurerm_resource_group" "dev" {
  name     = var.resource_group_dev
  location = var.location
}

# RG para produção
resource "azurerm_resource_group" "prod" {
  name     = var.resource_group_prod
  location = var.location
}

# ACR para imagens docker
resource "azurerm_container_registry" "acr" {
  name                = "${var.prefix}acr"
  resource_group_name = azurerm_resource_group.dev.name
  location            = azurerm_resource_group.dev.location
  sku                 = "Basic"
  admin_enabled       = true
}

# Storage Account com hierarquia habilitada (ADLS Gen2)
resource "azurerm_storage_account" "adls" {
  name                     = "${var.prefix}storage"
  resource_group_name      = azurerm_resource_group.dev.name
  location                 = azurerm_resource_group.dev.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  is_hns_enabled           = true  # Habilita Data Lake Gen2
  account_kind             = "StorageV2"
}

# Containers bronze/silver/gold
resource "azurerm_storage_container" "bronze" {
  name                  = "bronze"
  storage_account_name  = azurerm_storage_account.adls.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "silver" {
  name                  = "silver"
  storage_account_name  = azurerm_storage_account.adls.name
  container_access_type = "private"
}

resource "azurerm_storage_container" "gold" {
  name                  = "gold"
  storage_account_name  = azurerm_storage_account.adls.name
  container_access_type = "private"
}

# AKS cluster com identidade gerenciada
resource "azurerm_kubernetes_cluster" "aks" {
  name                = "${var.prefix}-aks"
  location            = azurerm_resource_group.dev.location
  resource_group_name = azurerm_resource_group.dev.name
  dns_prefix          = "${var.prefix}-k8s"

  default_node_pool {
    name       = "default"
    node_count = 2
    vm_size    = "Standard_DS3_v2"
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin = "azure"
    load_balancer_sku = "standard"
  }

  tags = {
    Environment = "Development"
  }
}
