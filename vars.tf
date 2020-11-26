variable "resource_group" {
  description = "Name of the Resource Group"
  default = "tf-demo"
}

variable "location" {
  description = " Location where the resources are created"
  
}

variable "web_vm_name" {
  description = "Name of the Virtual Machine for Web"
  default = "webserver-0" 
}


variable "db_vm_name" {
  description = "Name of the Virtual Machine for DB"
  default = "db-0" 
}


variable "username" {
  description = "Name of the user to login to the VM"
  default = "azadmin"
}

variable "password" {
  description  = "password for abc"
  
}