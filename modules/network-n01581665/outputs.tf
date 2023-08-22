output "n01581665-VNET-name" {
    value = azurerm_virtual_network.n01581665-VNET.name
}

output "n01581665-SUBNET" {
    value = {
        id = azurerm_subnet.n01581665-SUBNET.id
        name = azurerm_subnet.n01581665-SUBNET.name
    }
}