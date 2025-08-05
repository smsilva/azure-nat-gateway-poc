resource "azurerm_linux_virtual_machine" "spoke_core" {
  name                = "spoke-core"
  resource_group_name = azurerm_resource_group.core.name
  location            = azurerm_resource_group.core.location
  size                = var.virtual_machine_size

  admin_username                  = var.admin_username
  admin_password                  = var.virtual_machine_password
  network_interface_ids           = [azurerm_network_interface.spoke_core.id]
  disable_password_authentication = false

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "debian"
    offer     = "debian-11"
    sku       = "11"
    version   = "latest"
  }
}

resource "azurerm_network_interface" "spoke_core" {
  name                = "spoke-core"
  location            = azurerm_resource_group.core.location
  resource_group_name = azurerm_resource_group.core.name

  ip_configuration {
    name                          = "private-ip"
    subnet_id                     = azurerm_subnet.spoke_core_workloads.id
    private_ip_address_allocation = "Dynamic"
  }
}
