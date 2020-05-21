# terraform {
#   required_version = ">= 0.12.0"
# }
# provider "azurerm" {
#     version = "~>1.32.0"
#     use_msi = true
#     # subscription_id = "xxxxxxxxxxxxxxxxx"
#     # tenant_id       = "xxxxxxxxxxxxxxxxx"
# }

# resource "azurerm_resource_group" "hdirg" {
#   name     = "hdinsight-resources"
#   location = "West Europe"
# }
# data "azurerm_storage_account" "hdistorageaccount" {
#   name                = var.hdinsight_storage_account_name
#   resource_group_name = var.hdinsight_resource_group
# }


data "azurerm_virtual_network" "hdivnet" {
  name                = var.hdinsight_vnet_name
  resource_group_name = var.hdinsight_resource_group
}

data "azurerm_subnet" "hdisubnet" {
  name                = var.hdinsight_subnet_name
  resource_group_name = var.hdinsight_resource_group
  virtual_network_name = var.hdinsight_vnet_name
}

resource "azurerm_user_assigned_identity" "managedidentity" {
  resource_group_name = var.hdinsight_resource_group
  location            = var.location
  name = var.hdinsight-managed-identity-name
}
resource "azurerm_storage_account" "hdistorageaccount" {
  name                     = var.hdinsight_storage_account_name
  resource_group_name      = var.hdinsight_resource_group 
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "ZRS"
  account_kind="StorageV2"
}

resource "azurerm_storage_container" "hdistoragecontainer" {
  name                  = var.hdinsight_storage_container_name
  storage_account_name  = var.hdinsight_storage_account_name
  container_access_type = "private"
}

resource "azurerm_hdinsight_kafka_cluster" "hdicluster" {
  name                = var.hdinsight_cluster_name
  resource_group_name = var.hdinsight_resource_group
  location            = var.location
  cluster_version     = var.hdinsight_cluster_version
  tier                = "Standard"

  component_version {
    kafka = var.hdinsight_kafka_version
  }

  gateway {
    enabled  = true
    username = var.hdinsight_gateway_adminuser
    password = var.hdinsight_gateway_adminpassword
  }

  storage_account {
    storage_container_id = azurerm_storage_container.hdistoragecontainer.id
    storage_account_key  = azurerm_storage_account.hdistorageaccount.primary_access_key
    is_default           = true
  }
  # storage_account_gen2 {
  #   managed_identity_resource_id  = azurerm_storage_container.hdistoragecontainer.id
  #   # managed_identity_resource_id=azurerm_user_assigned_identity.managedidentity.id
  #   storage_resource_id   = azurerm_storage_account.hdistorageaccount.id
  #   filesystem_id=var.hdinsight_storage_file_system_id
  #   is_default           = true
  # }

  roles {
    head_node {
      vm_size  = "Standard_D3_V2"
      username = var.hdinsight_adminuser
      password = var.hdinsight_adminpassword
      virtual_network_id=data.azurerm_virtual_network.hdivnet.id
      subnet_id=data.azurerm_subnet.hdisubnet.id
    }

    worker_node {
      vm_size                  = "Standard_D3_V2"
      username = var.hdinsight_adminuser
      password = var.hdinsight_adminpassword
      number_of_disks_per_node = 3
      target_instance_count    = 3
      virtual_network_id=data.azurerm_virtual_network.hdivnet.id
      subnet_id=data.azurerm_subnet.hdisubnet.id
    }

    zookeeper_node {
      vm_size  = "Standard_D3_V2"
      username = var.hdinsight_adminuser
      password = var.hdinsight_adminpassword
      virtual_network_id=data.azurerm_virtual_network.hdivnet.id
      subnet_id=data.azurerm_subnet.hdisubnet.id
    }
  }
}