output "n01581665-vmlinux" {
    value = {
        ids = values(azurerm_linux_virtual_machine.n01581665-vmlinux)[*].id
        hostnames = values(azurerm_linux_virtual_machine.n01581665-vmlinux)[*].name
        nic_ids = values(azurerm_linux_virtual_machine.n01581665-vmlinux)[*].network_interface_ids[0]
        }
}

output "nic_id" {
    value = values(azurerm_linux_virtual_machine.n01581665-vmlinux)[*].network_interface_ids[0]
}

output "n01581665-vmlinux-FQDN" {
    value = values(azurerm_public_ip.n01581665-pip)[*].fqdn
}

output "n01581665-vmlinux-private-ip" {
    value = values(azurerm_linux_virtual_machine.n01581665-vmlinux)[*].private_ip_address
}

output "n01581665-vmlinux-public-ip" {
  value = values(azurerm_linux_virtual_machine.n01581665-vmlinux)[*].public_ip_address
}