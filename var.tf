variable "location" {
   # type = string
   type = list
   default = []
          
}

variable "region_count" {
    type = number
    default = 2
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




