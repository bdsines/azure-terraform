
variable "location" {
  type    = string
  default = "centralus"
}
variable "hdinsight_resource_group" {
    type = string  
}
variable "hdinsight_storage_account_name" {
    type = string  
}
variable "hdinsight_storage_container_name" {
    type = string  
}
variable "hdinsight_cluster_name" {
    type = string  
}
variable "hdinsight_cluster_version" {
    type = string
    default="4.0"  
}
variable "hdinsight_kafka_version" {
    type = string
    default="2.1"    
}
variable "hdinsight_adminuser" {
    type = string
    default="admin" 
}
variable "hdinsight_adminpassword" {
    type = string  
}
variable "hdinsight_gateway_adminuser" {
    type = string
    default="admin" 
}
variable "hdinsight_gateway_adminpassword" {
    type = string  
}
variable "hdinsight_vnet_name" {
    type = string  
}
variable "hdinsight_subnet_name" {
    type = string  
}
