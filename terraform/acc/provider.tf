terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.48.0"
    }
  }
  backend "azurerm" {
  }
}

provider "azurerm" {
  features {}
  # Configuration options
}

provider "azurerm" {
  alias           = "shared_networking"
  subscription_id = "ca095a5d-36c0-4d4f-82ff-83580d85ebba"
  features {}
}