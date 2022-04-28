terraform {
  required_version = ">= 0.12"
}

# Configure the Azure provider
provider "azurerm" {
  environment = "public"
  version     = ">= 3.0"
  subscription_id = var.subscriptionID
  features {
  }
}
