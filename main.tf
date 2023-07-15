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

module "common-n01579649" {
  source = "./modules/common-n01579649"

  rg-info = {
    name = module.rgroup-n01579649.rg-n01579649-info.name
    location = module.rgroup-n01579649.rg-n01579649-info.location
  }

  log_analytics_workspace-info = {
    name = "n01579649-log-analytics-workspace"
    sku = "PerGB2018"
    retention_in_days = 30
  }

  recovery_services_vault-info = {
    name = "n01579649-recovery-services-vault"
    sku = "Standard"
    soft_delete_mode = true
  }

  storage_account-info = {
    name = "n01579649storageaccount"
    account_tier = "Standard"
    account_replication_type = "LRS"
  }
}