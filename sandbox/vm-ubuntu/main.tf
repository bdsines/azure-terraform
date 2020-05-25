terraform {
  required_version = ">= 0.12.0"
}
provider "azurerm" {
    # version = "~>1.32"
    version = "~>2.0"
    use_msi = true
    skip_provider_registration=true
    features{}
    # subscription_id = "xxxxxxxxxxxxxxxxx"
    # tenant_id       = "xxxxxxxxxxxxxxxxx"
}

variable local_resource_group_name {
  type = string
  description="local resource group name"
}
module "virtual_network" {
  source = "../../modules/virtualmachine"
  vnet_name="vnet1"
  location = "westus"
  resource_group_name="${var.local_resource_group_name}"
  subnet_name=  "subnet1"
  vm_name="bdubuntu"
  nic_name="bdubuntunic"
  admin_username="admin"
  admin_password="Password1234!"
  tags = { ENV = "test"}
}