terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.48.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "acc-centric-tf-rg-ae-1"
    storage_account_name = "acccentrictfsaae1"
    container_name       = "acc-centric-tf-blob-ae-1"
    key                  = "acccentricsoltfsae1"
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