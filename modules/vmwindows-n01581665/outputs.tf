output "n01581665-vmwindows" {
    value = {
        ids = azurerm_windows_virtual_machine.n01581665-vmwindows[*].id
        hostnames = azurerm_windows_virtual_machine.n01581665-vmwindows[*].name
        }
}

output "n01581665-vmwindows-FQDN" {
    value = azurerm_public_ip.n01581665-vmwindows-pip[*].fqdn
}

output "n01581665-vmwindows-private-ip" {
    value = azurerm_windows_virtual_machine.n01581665-vmwindows[*].private_ip_address
}

output "n01581665-vmwindows-public-ip" {
    value = azurerm_windows_virtual_machine.n01581665-vmwindows[*].public_ip_address
}