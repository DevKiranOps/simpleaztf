resource "azurerm_public_ip" "web" {
  count = var.web_nodes
  name                = "webserver-${count.index}"
  resource_group_name = azurerm_resource_group.myapp.name
  location            = azurerm_resource_group.myapp.location
  allocation_method   = "Static"
  sku = "Standard"
  tags = {
    environment = "Testing"
  }
}

output "public_ips" {
  value = azurerm_public_ip.web.*.ip_address
}



resource "azurerm_network_interface" "myapp" {
  count = var.web_nodes
  name                = "webserver-count.index"
  location            = azurerm_resource_group.myapp.location
  resource_group_name = azurerm_resource_group.myapp.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.myapp.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = element(azurerm_public_ip.web.*.id, count.index)
  }
}

