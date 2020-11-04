variable "location" {
   # type = string
   type = map (string)
   default = {
       westeurope = "westeurope",}
          
}

variable "client_id" {
    default = {}
}

variable "client_secret" {
    default = {}
}

variable "admin_username" {
    default = {}
}

variable "admin_password" {
    default = {}
}

variable "tenant_id" {
    default = {}
}

variable "subscription_id" {
    default = {}
 }

variable "resource_group" {
    default = {}
}

variable "env_name" {
    type = string
    description = "The name of the environment"
}

variable "zones" {
    type = list(string)
    default = []
}

variable "prefix" {
    type = string
    default = "demo"
}

variable "ssh-source-address" {
    type    = string
    default = "*"
}




