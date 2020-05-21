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


module "hdinsight" {
  source = "../../modules/azure-hdinsight"
  location="centralus"
  hdinsight_resource_group="lab-architects-sandbox-bharath"
  hdinsight_storage_account_name="labarchitectssandboxbhar"
  hdinsight_storage_container_name="lab-hdinsight-kafka-02-20200519"
  hdinsight_cluster_name="lab-hdinsight-kafka-02"
  hdinsight_adminuser="nodeadmin"
  hdinsight_adminpassword="wearePackers123!"
  hdinsight_gateway_adminuser="clusteradmin"
  hdinsight_gateway_adminpassword="wearePackers123!"
  hdinsight_vnet_name="lab-bd-sandbox-vnet"
  hdinsight_subnet_name="snet-hdinsights"
  hdinsight-managed-identity-name="labmanagedidentity"
  hdinsight_storage_file_system_id="lab-hdinsight-kafka-02-fs"
}