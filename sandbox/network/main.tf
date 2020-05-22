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
  source = "../../modules/networking"
  vnet_name="vnet1"
  location = "westus"
  resource_group_name="${var.local_resource_group_name}"
  address_space=["10.0.0.0/16"]
  dns_servers=[]
  subnet_prefixes=["10.0.1.0/24","10.0.3.0/24","10.0.5.0/24"]
  subnet_names=  ["subnet1", "subnet2", "subnet3"]
  tags = { ENV = "test"}
}