module "prod" {
    source                      = "../modules/base environment"
    resource_group_name         = var.resource_group_name
    location                    = var.location
    subscription_id             = var.subscription_id
    environment                 = var.environment
    support_team_email          = var.support_team_email
    project_name                = var.project_name
    aks_node_pool_name          = var.aks_node_pool_name
    aks_node_count              = var.aks_node_count
    aks_vm_size                 = var.aks_vm_size
    aks_identity_type           = var.aks_identity_type
    storage_account_tier        = var.storage_account_tier
    account_replication_type    = var.account_replication_type
    sql_admin                   = var.sql_admin
    sql_password                = var.sql_password
    sql_database_name           = var.sql_database_name
    sql_database_sku            = var.sql_database_sku
}