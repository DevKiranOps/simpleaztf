provider "azurerm" {
  # whilst the `version` attribute is optional, we recommend pinning to a given version of the Provider
  version = "~>2.30.0"
  features {}
}


# Create a resource group
resource "azurerm_resource_group" "myapp" {
  name     = "tf-demo"
  location = "east us"
}


# Create a Virtual Network
resource "azurerm_virtual_network" "myapp" {
  name                = "tf-demo-vnet"
  location            = azurerm_resource_group.myapp.location
  resource_group_name = azurerm_resource_group.myapp.name
  address_space       = ["10.0.0.0/16"]

  tags = {
    Name = "tf-demo-vnet"
    project = "abc"
    environment = "Testing"
  }
}



resource "azurerm_resource_group" "myservice" {
  name     = "tf-service"
  location = "east us"
}


# Create a Virtual Network
resource "azurerm_virtual_network" "myservice" {
  name                = "tf-service-vnet"
  location            = azurerm_resource_group.myservice.location
  resource_group_name = azurerm_resource_group.myservice.name
  address_space       = ["172.16.0.0/16"]

  tags = {
    Name = "tf-service-vnet"
    project = "abc"
    environment = "Testing"
  }
}



