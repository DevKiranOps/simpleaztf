#Network Security Group for Web servers

resource "azurerm_network_security_group" "web" {
  name                = "web-nsg"
  location            = azurerm_resource_group.myapp.location
  resource_group_name = azurerm_resource_group.myapp.name

  tags = {
    environment = "Production"
  }
}

# Network Security Group rule -1 for Web servers
resource "azurerm_network_security_rule" "SSH" {
  name                        = "web-rule-0"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "22"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.myapp.name
  network_security_group_name = azurerm_network_security_group.web.name
}

# Network Security Group rule -2 for Web servers

resource "azurerm_network_security_rule" "HTTP" {
  name                        = "web-rule-1"
  priority                    = 200
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "80"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.myapp.name
  network_security_group_name = azurerm_network_security_group.web.name
}


# Subnet association with NSG
resource "azurerm_subnet_network_security_group_association" "web" {
  subnet_id                 = azurerm_subnet.myapp.id
  network_security_group_id = azurerm_network_security_group.web.id
}



resource "azurerm_network_security_group" "db" {
  name                = "db-nsg"
  location            = azurerm_resource_group.myapp.location
  resource_group_name = azurerm_resource_group.myapp.name

  tags = {
    environment = "Testing"
  }
}


resource "azurerm_network_security_rule" "db" {
  name                        = "db-rule-0"
  priority                    = 100
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "3306"
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = azurerm_resource_group.myapp.name
  network_security_group_name = azurerm_network_security_group.db.name
}








