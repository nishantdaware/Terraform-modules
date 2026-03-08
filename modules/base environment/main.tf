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

################
# Compute Subnet
################

resource "azurerm_subnet" "snet" {
  name                 = "snet-${var.environment}"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

#################
# Storage Account
#################

resource "random_string" "suffix" {
  length  = 6
  upper   = false
  special = false
  numeric = true
}

resource "azurerm_storage_account" "storage" {
  name                     = lower("storage${var.environment}${random_string.suffix.result}")
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
  name                         = lower("sql-${var.environment}-${random_string.suffix.result}")
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

##################
# Virtual Machines
##################

resource "azurerm_network_interface" "vm_nic" {
  name                = "vm-${var.environment}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "vm-nic-ip-config"
    subnet_id                     = azurerm_subnet.snet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "linux-vm" {
  name                = "vm-${var.environment}"
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.vm_size
  admin_username      = var.vm_admin_username
  network_interface_ids = [
    azurerm_network_interface.vm_nic.id,
  ]

  admin_ssh_key {
    username   = var.vm_admin_username
    public_key = file("C:/Users/Nishant/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = var.storage_account_type
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts"
    version   = "latest"
  }
}

#############################
# Load Balancer Configuration
#############################

resource "azurerm_public_ip" "lb_ip" {
  name                = "vm-lb-ip-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
}

resource "azurerm_lb" "vm_lb" {
  name                = "vm-lb-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name

  frontend_ip_configuration {
    name                 = "vm-lb-pip-config"
    public_ip_address_id = azurerm_public_ip.lb_ip.id
  }
}

resource "azurerm_lb_backend_address_pool" "vm_lb_backend_pool" {
  loadbalancer_id = azurerm_lb.vm_lb.id
  name            = "vm-lb-backend-pool-${var.environment}"
}

resource "azurerm_network_interface_backend_address_pool_association" "vm_lb_nic_assoc" {
  network_interface_id    = azurerm_network_interface.vm_nic.id
  ip_configuration_name   = azurerm_network_interface.vm_nic.ip_configuration[0].name
  backend_address_pool_id = azurerm_lb_backend_address_pool.vm_lb_backend_pool.id
}

resource "azurerm_lb_probe" "vm_lb_probe" {
  loadbalancer_id = azurerm_lb.vm_lb.id
  name            = "ssh-probe-${var.environment}"
  port            = 22
}

resource "azurerm_lb_rule" "vm_lb_rule" {
  loadbalancer_id                = azurerm_lb.vm_lb.id
  name                           = "ssh-lb-rule-${var.environment}"
  protocol                       = "Tcp"
  frontend_port                  = 22
  backend_port                   = 22
  frontend_ip_configuration_name = azurerm_lb.vm_lb.frontend_ip_configuration[0].name
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.vm_lb_backend_pool.id]
  probe_id                       = azurerm_lb_probe.vm_lb_probe.id
}