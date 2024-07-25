# Variables
variable "client_id" {
    description = "Client ID"
    default = "ba9d75cb-94c6-443c-8a8c-097fdf365423"
}
variable "client_secret" {
    description =" Client description"
    default = "4eT8Q~c0D~2pMo0qPXJrp52wcAYv3hxiUuWrpcd1"
}
 
variable "tenant_id"  { 
    description =" Tenant ID"
    default = "cdf226d7-79fd-4290-a3a7-996968201a26"
}

variable "subscription_id"  { 
    description =" Subscription ID"
    type = string
}

variable "resource_groups"{
    description = "Map of resource group name and their locations"
    type = map(object({
      rg_name = string
      location = string
      virtual_network = string
      tags = map(string)
}))
default = {
    
},

variable "vm_list"{
    description = "VM Resource List"
    type = list(object({
        rg_name = string
        rg_vnet_name = string
        rg_location = string
        virtual_network_name = string
        subnet  = string
        vm_name = string
        vm_size = string
        storage_account_type = string
        source_image_id = string
        admin_username = string
        admin_password = string
        tags = map(string)
    }))
    default = null
}

variable "subscription_id" {
  type        = string
  description = "Subscription ID"
}

variable "domains" {
  type        = list(string)
  description = "List of domains"
}

variable "domainadmins" {
  type        = list(string)
  description = "List of domain admins"
}

variable "domainpasswords" {
  type        = list(string)
  description = "List of domain passwords"
}

variable "domainusers" {
  type        = list(string)
  description = "List of domain users"
}

variable "oupaths" {
  type        = list(string)
  description = "List of OU paths"
}
