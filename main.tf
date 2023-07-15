module "rgroup-n01579649" {
  source = "./modules/rgroup-n01579649"

  rg-n01579649-info = {
    name = "n01579649-RG"
    location = "centralindia"
  }
}

module "network-n01579649" {
  source = "./modules/network-n01579649"

  VNET-n01579649-info = {
    name = "n01579649-VNET"
    resource_group_name = module.rgroup-n01579649.rg-n01579649-info.name
    location = module.rgroup-n01579649.rg-n01579649-info.location
  }
  VNET-n01579649-address_space = ["10.0.0.0/16"]

  SUBNET-n01579649-info = {
    name = "n01579649-SUBNET"
  }
  SUBNET-n01579649-address_prefixes = ["10.0.0.0/24"]
}