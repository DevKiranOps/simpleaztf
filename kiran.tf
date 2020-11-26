provider "azurerm" {
  # whilst the `version` attribute is optional, we recommend pinning to a given version of the Provider
  version = "~>2.30.0"
  features {}
}




# Create a resource group
resource "azurerm_resource_group" "myapp" {
  name     = var.resource_group
  location = var.region
}
