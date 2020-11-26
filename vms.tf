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


resource "azurerm_virtual_machine" "db" {
  name                  = "db-0"
  location              = azurerm_resource_group.myapp.location
  resource_group_name   = azurerm_resource_group.myapp.name
  network_interface_ids = [azurerm_network_interface.db.id]
  vm_size               = "Standard_B1s"

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
    name              = "mydbdisk1"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "db-0"
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



