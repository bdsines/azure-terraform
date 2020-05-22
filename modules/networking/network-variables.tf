variable "location" {
  description = "Region of the vnet/rg"
  default     = "westus"
}
variable "vnet_name" {
  description = "Name of the vnet to create"
  default     = "acctvnet"
}

variable "resource_group_name" {
  description = "Name of the resource group to be imported."
}

variable "address_space" {
  type        = list(string)
  description = "The address space that is used by the virtual network."
  default     = ["10.0.0.0/16"]
}

# If no values specified, this defaults to Azure DNS 
variable "dns_servers" {
  description = "The DNS servers to be used with vNet."
  default     = []
}

variable "subnet_prefixes" {
  description = "The address prefix to use for the subnet."
  default     = ["10.0.1.0/24","10.0.3.0/24","10.0.5.0/24"]
}

variable "subnet_names" {
  description = "A list of public subnets inside the vNet."
  default     = ["subnet1", "subnet2", "subnet3"]
}

variable "subnet_security_group_names" {
  description = "A map of subnet name to Network Security Group IDs"
  type        = map(string)

  default = {"subnet1":"nsg1","subnet2":"nsg2","subnet3":"nsg3"
  }
}

variable "tags" {
  description = "The tags to associate with your network and subnets."
  type        = map(string)

  default = {
    ENV = "test"
  }
}