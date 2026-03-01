// Providers block can be copied from terraform registry

terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {

  // The features {} block is mandatory in the azurerm provider, even if it's empty. 
  // Omitting it will cause an error like: The provider configuration is invalid
  
  features {} 

  resource_provider_registrations = "none"
  subscription_id = var.subscription_id // This is temporary subscription id
}