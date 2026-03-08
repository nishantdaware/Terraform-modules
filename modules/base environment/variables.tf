
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

###########################
# Virtual Machine Variables
###########################

variable "vm_size" {
  type = string
  description = "Virtual machine size, e.g. Standard_F2"
}

variable "vm_admin_username" {
  type = string
  description = "Virtual machine administrator username"
}

variable "storage_account_type" {
  type = string
  description = "Storage account type, e.g. Standard_LRS/Premium_LRS"
}