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


# Create a frontend Subnet

resource "azurerm_subnet" "myapp" {
  name                 = "frontend"
  resource_group_name  = azurerm_resource_group.myapp.name
  virtual_network_name = azurerm_virtual_network.myapp.name
  address_prefixes     = ["10.0.1.0/24"]

  
}

resource "azurerm_subnet" "myapp-backend" {
  name                 = "backend"
  resource_group_name  = azurerm_resource_group.myapp.name
  virtual_network_name = azurerm_virtual_network.myapp.name
  address_prefixes     = ["10.0.2.0/24"]

  
}


resource "azurerm_network_interface" "myapp" {
  name                = "webserver-0"
  location            = azurerm_resource_group.myapp.location
  resource_group_name = azurerm_resource_group.myapp.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.myapp.id
    private_ip_address_allocation = "Dynamic"
  }
}

