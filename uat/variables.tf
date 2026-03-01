
###############################
#Variables for Base Environment
###############################

variable "resource_group_name" {
  type = string
  default = "1-5befc17b-playground-sandbox"
}

variable "location" {
  type = string
  default = "eastus"
}

variable "subscription_id" {
  type = string
  default = "2213e8b1-dbc7-4d54-8aff-b5e315df5e5b"
}

###############
#Tags variables
###############

variable "environment" {
  type = string
  default = "uat"
}

variable "support_team_email" {
  type = string
  default = "dawarenishant13@gmail.com"
}

variable "project_name" {
  type = string
  default = "Terraform Modules Hands On"
}

##############
#AKS Variables
##############

variable "aks_node_pool_name" {
  type = string
  description = "Aks node pool name, e.g. default/nodepool1"
  default = "nodepooluat"
}

variable "aks_node_count" {
  type = number
  description = "Number of node count, e.g. 2/3/4"
  default = 2
}

variable "aks_vm_size" {
  type = string
  description = "Aks VM size, e.g. Standard_B2s/Standard_D2s_v3"
  default = "Standard_B2s"
}

variable "aks_identity_type" {
  type = string
  description = "Aks Identity type, e.g. SystemAssigned/UserAssigned/None"
  default = "SystemAssigned"
}

###########################
# Storage Account Variables
###########################

variable "storage_account_tier" {
  type = string
  description = "Storage account tier, e.g. Standard/Premium"
  default = "Standard"
}

variable "account_replication_type" {
  type = string
  description = "Storage account replication type, e.g. LRS/GRS/ZRS"
  default = "LRS"
}

######################
# SQL Server Variables
######################

variable "sql_admin_uat" {
  type = string
  description = "SQL Server administrator login name, e.g. sqladmin"
  default = "sqladminuat"
}

variable "sql_password_uat" {
  type = string
  description = "SQL Server administrator login password"
  sensitive = true
}

variable "sql_database_name" {
  type = string
  description = "SQL Database name, e.g. mydatabase"
  default = "mydatabaseuat"
}

variable "sql_database_sku" {
  type = string
  description = "SQL Database SKU, e.g. Basic/S0/S1/P1"
  default = "Basic"
}