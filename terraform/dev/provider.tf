terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "3.25.0"
    }
  }
  backend "azurerm" {
     resource_group_name = "poc-centric-tf-rg-ae-1"
     storage_account_name = "poccentrictfsaae1"
     container_name = "poc-centric-tf-blob-ae-1"
     key    = "poc-centric-project-dev.tfstate"

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