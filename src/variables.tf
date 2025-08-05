variable "location" {
  type        = string
  description = "Location for all resources."
  default     = "eastus"
}

variable "resource_group_name" {
  type    = string
  default = "wasp-cloud-poc"
}

variable "virtual_machine_size" {
  type        = string
  description = "Size of the virtual machine."
  default     = "Standard_D2_v3"
}

variable "virtual_machine_password" {
  type      = string
  sensitive = true
}

variable "admin_username" {
  type        = string
  description = "Value of the admin username."
  default     = "azureuser"
}
