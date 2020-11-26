resource "azurerm_public_ip" "web" {
  name                = "webserver"
  resource_group_name = azurerm_resource_group.myapp.name
  location            = azurerm_resource_group.myapp.location
  allocation_method   = "Dynamic"

  tags = {
    environment = "Testing"
  }
}


resource "azurerm_network_interface" "myapp" {
  name                = "webserver-0"
  location            = azurerm_resource_group.myapp.location
  resource_group_name = azurerm_resource_group.myapp.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.myapp.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.web.id
  }
}




resource "azurerm_network_interface" "db" {
  name                = "db-0"
  location            = azurerm_resource_group.myapp.location
  resource_group_name = azurerm_resource_group.myapp.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.myapp.id
    private_ip_address_allocation = "Dynamic"
    
  }
}
