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

