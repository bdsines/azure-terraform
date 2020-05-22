variable "location" {
  description = "Region of the vnet/rg"
  default     = "westus"
}

variable "resource_group_name" {
  description = "Name of the resource group to be imported."
}

variable "subnet_name" {
  description = "A list of public subnets inside the vNet."
  default     = "subnet1"
}

variable "storage_account_name" {
  description = "Storage Account name"
  type        = string

}


variable "tags" {
  description = "The tags to associate with your network and subnets."
  type        = map(string)

  default = {
    ENV = "test"
  }
}