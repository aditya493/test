terraform {
  required_providers{
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.96.0"
        }
    }


# configure the mIcrosoft Azure required_providers
provider "azurerm" {
  features{}
  client_id = var.client_id 
  client_secret = var.client_secret
  tenant_id = var.tenant_id
  subscription id = var.subscription_id
  
  