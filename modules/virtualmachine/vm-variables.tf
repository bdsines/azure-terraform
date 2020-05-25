variable "location" {
  description = "Region of the vnet/rg"
  default     = "westus"
}

variable "resource_group_name" {
  description = "Name of the resource group to be imported."
}

variable "vnet_name" {
  description = "Name of the vnet."
  default     = "vnet1"
}

variable "subnet_name" {
  description = "Subnet inside the vNet."
  default     = "subnet1"
}


variable "vm_name" {
  description = "Virtual Machine name"
  type        = string

}
variable "nic_name" {
  description = "NIC name"
  type        = string

}

variable "admin_username" {
  description = "Host Admin User"
  type        = string

}
variable "admin_password" {
  description = "Host Admin User Password"
  type        = string

}
variable "tags" {
  description = "The tags to associate with your network and subnets."
  type        = map(string)

  default = {
    ENV = "test"
  }
}