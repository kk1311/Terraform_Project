# Resource group
output "rg-n01579649-name" {
    value = module.rgroup-n01579649.rg-n01579649-info.name
}

# Network resources
output "n01579649-VNET-name" {
    value = module.network-n01579649.n01579649-VNET-name
}

output "n01579649-SUBNET" {
    value = module.network-n01579649.n01579649-SUBNET
}