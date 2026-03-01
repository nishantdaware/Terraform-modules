################
#local variables
################  

locals {
  default_tags = {
    environment        = var.environment
    support_team_email = var.support_team_email
    project_name       = var.project_name
  }
}