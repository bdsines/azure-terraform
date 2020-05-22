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
module "storage" {
  source = "../../modules/storage"
  vnet_name="vnet1"
  subnet_name="subnet1"
  location = "westus"
  resource_group_name="${var.local_resource_group_name}"
  storage_account_name=  "bdstorageacct123"
  tags = { ENV = "test"}
}