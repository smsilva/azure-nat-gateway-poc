resource "random_pet" "resource_group_name" {
  prefix = var.resource_group_name
}

resource "azurerm_resource_group" "default" {
  name     = random_pet.resource_group_name.id
  location = var.location
}

resource "azurerm_resource_group" "core" {
  name     = "${random_pet.resource_group_name.id}-core"
  location = var.location
}
