variable "tags" {
    type = map(string)
    description = "Contains local tags"  
}

variable "rg-info" {
    type = map(string)
    description = "Contains information about the resource group for Windows machine"
}

variable "instance_count" {
    type = number
    description = "Total number of Windows VMs"
}

variable "n01581665-vmwindows-info" {
    type = any
    description = "Contains information about the Windows VM" 
}

variable "n01581665-vmwindows-avs-info" {
    type = any
    description = "Contains information about the Windows Availability set"
}

variable "n01581665-vmwindows-nic" {
    type = any
    description = "Contains information about the Windows' Network interface"
}

variable "n01581665-vmwindows-pip" {
    type = any
    description = "Contains information about the Windows' Public IP config"
}

variable "n01581665-vmwindows-antimalware" {
    type = any
    description = "Contains information about the Windows' Antimalware"
}