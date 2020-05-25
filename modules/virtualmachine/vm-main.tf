data azurerm_resource_group "vmrg" {
  name = var.resource_group_name
  #location=var.location
}
data azurerm_subnet "vmsubnet" {
  resource_group_name  = data.azurerm_resource_group.vmrg.name
  virtual_network_name  = var.vnet_name
  name = var.subnet_name
}
resource "azurerm_network_interface" "vmnic" {
  name                = var.nic_name
  location            = data.azurerm_resource_group.vmrg.location
  resource_group_name = data.azurerm_resource_group.vmrg.name

  ip_configuration {
    name                          = "${var.nic_name}-ipconfig"
    subnet_id                     = data.azurerm_subnet.vmsubnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_virtual_machine" "vm" {
  name                  = var.vm_name
  location              = data.azurerm_resource_group.vmrg.location
  resource_group_name   = data.azurerm_resource_group.vmrg.name
  network_interface_ids = [azurerm_network_interface.vmnic.id]
  vm_size               = "Standard_DS1_v2"

  # Uncomment this line to delete the OS disk automatically when deleting the VM
  # delete_os_disk_on_termination = true

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "16.04-LTS"
    version   = "latest"
  }
  storage_os_disk {
    name              = "${var.vm_name}-osdisk"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }
  os_profile {
    computer_name  = "hostname"
    admin_username = var.admin_username
    admin_password = var.admin_password
  }
  os_profile_linux_config {
    disable_password_authentication = false
  }
  tags = var.tags
}

