provider "azurerm" {
    version = "~>1.32.0"
    use_msi = true
    subscription_id = "xxxxxxxxxxxxxxxxx"
    tenant_id       = "xxxxxxxxxxxxxxxxx"
}
# resource "azurerm_resource_group" "hdirg" {
#   name     = "hdinsight-resources"
#   location = "West Europe"
# }

resource "azurerm_storage_account" "hdistorageaccount" {
  name                     = var.hdinsight_storage_account_name
  resource_group_name      = var.hdinsight_resource_group 
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "hdistoragecontainer" {
  name                  = var.hdinsight_storage_container_name
  resource_group_name   = var.hdinsight_resource_group
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

  roles {
    head_node {
      vm_size  = "Standard_D3_V2"
      username = var.hdinsight_adminuser
      password = var.hdinsight_adminpassword
    }

    worker_node {
      vm_size                  = "Standard_D3_V2"
      username = var.hdinsight_adminuser
      password = var.hdinsight_adminpassword
      number_of_disks_per_node = 3
      target_instance_count    = 3
    }

    zookeeper_node {
      vm_size  = "Standard_D3_V2"
      username = var.hdinsight_adminuser
      password = var.hdinsight_adminpassword
    }
  }
}