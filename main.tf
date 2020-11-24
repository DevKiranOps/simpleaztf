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




resource "azurerm_virtual_machine" "myapp" {
  name                  = "webserver-0"
  location              = azurerm_resource_group.myapp.location
  resource_group_name   = azurerm_resource_group.myapp.name
  network_interface_ids = [azurerm_network_interface.myapp.id]
  vm_size               = "Standard_B1ls"

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  # delete_os_disk_on_termination = true

  # Uncomment this line to delete the data disks automatically when deleting the VM
  # delete_data_disks_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
  storage_os_disk {
    name              = "myosdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "webserver-0"
    admin_username = "azadmin"
    
  }
  os_profile_linux_config {
    disable_password_authentication = true

    ssh_keys {
      key_data = file("~/.ssh/id_rsa.pub")
      path     = "/home/azadmin/.ssh/authorized_keys"
    }
  }

  tags = {
    environment = "testing"
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
  }
}

