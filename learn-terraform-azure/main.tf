# Configure the Azure provider
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 2.65"
    }
  }

  required_version = ">= 0.14.9"
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name  
  location = "westus2"
    tags = {
      Environment = "Terraform Getting Started"
      Team = "DevOps"
    }
}

# Create a virtual network
resource "azurerm_virtual_network" "vnet" {
    name                = "myTFVnet"
    address_space       = ["10.100.0.0/16"]
    location            = "westus2"
    resource_group_name = azurerm_resource_group.rg.name    
}

resource "azurerm_subnet" "snet" {
  name                 = "subnet2"
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = "myTFVnet"
  address_prefixes     = ["10.100.1.0/24"]
}
