data azurerm_resource_group "storagerg" {
  name = var.resource_group_name
  location=var.location
}
data azurerm_subnet "storagesubnet" {
  resource_group_name  = azurerm_resource_group.storagerg.name
  virtual_network_name  = var.vnet_name
  name = var.subnet_name
}

resource "azurerm_storage_account" "storageaccount" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.storagerg.name
  location                 = azurerm_resource_group.storagerg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = var.tags
}

resource "azurerm_storage_account_network_rules" "test" {
  resource_group_name  = azurerm_resource_group.storagerg.name
  storage_account_name = azurerm_storage_account.storageaccount.name

  default_action             = "Allow"
  ip_rules                   = ["127.0.0.1"]
  virtual_network_subnet_ids = [azurerm_subnet.storagesubnet.id]
  bypass                     = ["Metrics"]
}