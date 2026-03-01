
###############################
#Variables for Base Environment
###############################

variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "subscription_id" {
  type = string
}

###############
#Tags variables
###############

variable "environment" {
  type = string
  description = "Environment e.g prod/uat/staging"
}

variable "support_team_email" {
  type = string
  description = "Support Team Email"
}

variable "project_name" {
  type = string
  description = "Project Name"
}

##############
#AKS Variables
##############

variable "aks_node_pool_name" {
  type = string
  description = "Aks node pool name, e.g. default/nodepool1"
}

variable "aks_node_count" {
  type = number
  description = "Number of node count, e.g. 2/3/4"
}

variable "aks_vm_size" {
  type = string
  description = "Aks VM size, e.g. Standard_B2s/Standard_D2s_v3"
}

variable "aks_identity_type" {
  type = string
  description = "Aks Identity type, e.g. SystemAssigned/UserAssigned/None"
}

###########################
# Storage Account Variables
###########################

variable "storage_account_tier" {
  type = string
  description = "Storage account tier, e.g. Standard/Premium"
}

variable "account_replication_type" {
  type = string
  description = "Storage account replication type, e.g. LRS/GRS/ZRS"
}

######################
# SQL Server Variables
######################

variable "sql_admin" {
  type = string
  description = "SQL Server administrator login name, e.g. sqladmin"
}

variable "sql_password" {
  type = string
  description = "SQL Server administrator login password"
  sensitive = true
}

variable "sql_database_name" {
  type = string
  description = "SQL Database name, e.g. mydatabase"
}

variable "sql_database_sku" {
  type = string
  description = "SQL Database SKU, e.g. Standard/premium"
}