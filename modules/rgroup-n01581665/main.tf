resource "azurerm_resource_group" "n01581665-RG" {
    name = var.rg-n01581665-info.name
    location = var.rg-n01581665-info.location
    tags = var.tags
}