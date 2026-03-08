
###############################
#Variables for Base Environment
###############################

variable "resource_group_name" {
  type = string
  default = "1-58276c2f-playground-sandbox"
}

variable "location" {
  type = string
  default = "southcentralus"
}

variable "subscription_id" {
  type = string
  default = "28e1e42a-4438-4c30-9a5f-7d7b488fd883"
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

variable "sql_admin" {
  type = string
  description = "SQL Server administrator login name, e.g. sqladmin"
  default = "sqladminuat"
}

variable "sql_password" {
  type = string
  description = "SQL Server administrator login password"
  sensitive = true
}

variable "sql_database_name" {
  type = string
  description = "SQL Database name, e.g. mydatabase"
  default = "dbuat"
}

variable "sql_database_sku" {
  type = string
  description = "SQL Database SKU, e.g. Basic/S0/S1/P1"
  default = "Basic"
}

###########################
# Virtual Machine Variables
###########################

variable "vm_size" {
  type = string
  description = "Virtual machine size, e.g. Standard_B1s/Standard_F2"
  default = "Standard_B1s"
}

variable "vm_admin_username" {
  type = string
  description = "Virtual machine administrator username"
  default = "vm_admin_uat"
}

variable "storage_account_type" {
  type = string
  description = "Storage account type, e.g. Standard_LRS/Premium_LRS"
  default = "Standard_LRS"
}