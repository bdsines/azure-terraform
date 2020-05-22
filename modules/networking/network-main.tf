#Azure Generic vNet Module
# provider "azurerm" {
#  version = 2.10
#  features {}

# }
# resource "azurerm_resource_group" "vnet" {
#   name     = var.resource_group_name
#   location = var.location
# }
data azurerm_resource_group "vnet" {
  name = var.resource_group_name
}
resource "azurerm_network_security_group" "vnetnsg" {
  for_each                  = var.subnet_security_group_names
  name                = each.key
  location            = var.location
  resource_group_name = data.azurerm_resource_group.vnet.name
}
resource azurerm_virtual_network "vnet" {
  name                = var.vnet_name
  resource_group_name = data.azurerm_resource_group.vnet.name
  location            = data.azurerm_resource_group.vnet.location
  address_space       = var.address_space
  dns_servers         = var.dns_servers
  tags                = var.tags
}
resource azurerm_subnet "subnet" {
  count                = length(var.subnet_names)
  name                 = var.subnet_names[count.index]
  resource_group_name  = data.azurerm_resource_group.vnet.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefix       = var.subnet_prefixes[count.index]
  service_endpoints =["Microsoft.Storage","Microsoft.AzureActiveDirectory"]
}

data azurerm_subnet "import" {
  for_each             = var.subnet_security_group_names
  name                 = each.key
  resource_group_name  = data.azurerm_resource_group.vnet.name
  virtual_network_name = azurerm_virtual_network.vnet.name

  depends_on = [azurerm_subnet.subnet]
}

resource azurerm_subnet_network_security_group_association "vnet" {
  
  for_each                  = azurerm_network_security_group.vnetnsg
  # for_each                  = var.nsg_ids
  subnet_id                 = data.azurerm_subnet.import[each.key].id
  network_security_group_id = each.value.id

  depends_on = [data.azurerm_subnet.import]
}
