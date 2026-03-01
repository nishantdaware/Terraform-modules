
#################
# Virtual Network
#################

resource "azurerm_virtual_network" "vnet" {
  name                = "vnet-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = ["10.0.0.0/16"]

  tags = local.default_tags
}

#################
# Subnet for AKS
#################

resource "azurerm_subnet" "aks_subnet" {
  name                 = "aks-subnet-${var.environment}"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

###################
#Kubernetes Cluster
###################

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks-cluster-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "voter-app-${var.environment}"

  default_node_pool { 
    name            = var.aks_node_pool_name
    node_count      = var.aks_node_count
    vm_size         = var.aks_vm_size
    vnet_subnet_id  = azurerm_subnet.aks_subnet.id
  }

  identity {
    type = var.aks_identity_type
  }

  network_profile {
    network_plugin = "azure"

    service_cidr   = "10.2.0.0/16"   # Different range
    dns_service_ip = "10.2.0.10"     # Must be inside service_cidr
  }

  tags = local.default_tags    
}

#################
# Storage Account
#################

resource "azurerm_storage_account" "storage" {
  name                     = lower("storage${var.environment}123456")
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = var.storage_account_tier
  account_replication_type = var.account_replication_type

  tags = local.default_tags
}

#########################
# SQL Server and Database
#########################

resource "azurerm_mssql_server" "sql" {
  name                         = lower("sql-${var.environment}-123456")
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.sql_admin
  administrator_login_password = var.sql_password

  tags = local.default_tags
}

resource "azurerm_mssql_database" "database" {
  name      = var.sql_database_name
  server_id = azurerm_mssql_server.sql.id
  sku_name  = var.sql_database_sku
}

