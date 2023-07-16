module "rgroup-n01579649" {
  source = "./modules/rgroup-n01579649"

  rg-n01579649-info = {
    name     = "n01579649-RG"
    location = "centralindia"
  }
}

module "network-n01579649" {
  source = "./modules/network-n01579649"

  VNET-n01579649-info = {
    name                = "n01579649-VNET"
    resource_group_name = module.rgroup-n01579649.rg-n01579649-info.name
    location            = module.rgroup-n01579649.rg-n01579649-info.location
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
    name     = module.rgroup-n01579649.rg-n01579649-info.name
    location = module.rgroup-n01579649.rg-n01579649-info.location
  }

  log_analytics_workspace-info = {
    name              = "n01579649-log-analytics-workspace"
    sku               = "PerGB2018"
    retention_in_days = 30
  }

  recovery_services_vault-info = {
    name             = "n01579649-recovery-services-vault"
    sku              = "Standard"
    soft_delete_mode = true
  }

  storage_account-info = {
    name                     = "n01579649storageaccount"
    account_tier             = "Standard"
    account_replication_type = "LRS"
  }
}

module "vmlinux-n01579649" {
  source = "./modules/vmlinux-n01579649"

  rg-info = {
    name     = module.rgroup-n01579649.rg-n01579649-info.name
    location = module.rgroup-n01579649.rg-n01579649-info.location
  }

  instance_count = 3

  n01579649-vmlinux-info = {
    name          = "n01579649-linux"
    computer_name = "n01579649-computer_name"
    size          = "Standard_B1s"

    storage_account_uri = module.common-n01579649.storage_account-primary_blob_endpoint

    admin_ssh_key = {
      admin_username = "n01579649-nisargkumar"
      public_key     = "C:\\Users\\Nisarg Mahyavanshi\\automation\\terraform\\lab02s3\\vm_ssh_key\\id_rsa.pub"
    }

    private_key = "C:\\Users\\Nisarg Mahyavanshi\\automation\\terraform\\lab02s3\\vm_ssh_key\\id_rsa"

    os_disk = {
      storage_account_type = "Standard_LRS"
      disk_size_gb         = "32"
      caching              = "ReadWrite"
    }

    source_image_reference = {
      publisher = "OpenLogic"
      offer     = "CentOS"
      sku       = "8_2"
      version   = "latest"
    }
  }

  n01579649-vmlinux-avs-info = {
    name                         = "n01579649-linux-avs"
    platform_update_domain_count = "4"
    platform_fault_domain_count  = "2"
  }

  n01579649-vmlinux-nic = {
    ip_configuration = {
      subnet_id                     = module.network-n01579649.n01579649-SUBNET.id
      private_ip_address_allocation = "Dynamic"
    }
  }

  n01579649-vmlinux-pip = {
    allocation_method       = "Dynamic"
    idle_timeout_in_minutes = "30"
  }

  n01579649-vmlinux-network-watcher = {
    publisher                  = "Microsoft.Azure.NetworkWatcher"
    type                       = "NetworkWatcherAgentLinux"
    type_handler_version       = "1.0"
    auto_upgrade_minor_version = true

    settings = <<SETTINGS
        {}
    SETTINGS
  }

  n01579649-vmlinux-network-monitor = {
    publisher                  = "Microsoft.Azure.Monitor"
    type                       = "AzureMonitorLinuxAgent"
    type_handler_version       = "1.0"
    auto_upgrade_minor_version = true

    settings = <<SETTINGS
      {}
  SETTINGS

  }
}
