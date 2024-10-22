terraform {
  required_providers {
    restapi = {
      source = "Mastercard/restapi"
      version = ">= 1.20.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 4.5.0"
    }    
  }
}
