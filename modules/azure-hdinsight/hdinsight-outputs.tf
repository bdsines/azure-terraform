output hdistorage_account_key {
    value=azurerm_storage_account.hdistorageaccount.primary_access_key
}
output hdistorage_https_endpoint {
    value=azurerm_hdinsight_kafka_cluster.hdicluster.https_endpoint
}
output hdistorage_ssh_endpoint {
    value=azurerm_hdinsight_kafka_cluster.hdicluster.ssh_endpoint
}