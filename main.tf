# Common Local block for all modules
locals {
  assignment01_tags = {
    Assignment     = "CCGC 5502 Automation Assignment"
    Name           = "Kartik.Sharma"
    ExpirationDate = "2024-12-31"
    Environment    = "Learning"
  }
}


# Resource group module
module "rgroup-n01581665" {
  source = "./modules/rgroup-n01581665"

  tags = local.assignment01_tags

  rg-n01581665-info = {
    name     = "n01581665-RG"
    location = "centralindia"
  }
}

# Network module
module "network-n01581665" {
  source = "./modules/network-n01581665"

  tags = local.assignment01_tags

  VNET-n01581665-info = {
    name                = "n01581665-VNET"
    resource_group_name = module.rgroup-n01581665.rg-n01581665-info.name
    location            = module.rgroup-n01581665.rg-n01581665-info.location
  }
  VNET-n01581665-address_space = ["10.0.0.0/16"]

  SUBNET-n01581665-info = {
    name = "n01581665-SUBNET"
  }
  SUBNET-n01581665-address_prefixes = ["10.0.0.0/24"]
}

# Common module
module "common-n01581665" {
  source = "./modules/common-n01581665"

  tags = local.assignment01_tags

  rg-info = {
    name     = module.rgroup-n01581665.rg-n01581665-info.name
    location = module.rgroup-n01581665.rg-n01581665-info.location
  }

  log_analytics_workspace-info = {
    name              = "n01581665-log-analytics-workspace"
    sku               = "PerGB2018"
    retention_in_days = 30
  }

  recovery_services_vault-info = {
    name             = "n01581665-recovery-services-vault"
    sku              = "Standard"
    soft_delete_mode = true
  }

  storage_account-info = {
    name                     = "n01581665storageaccount"
    account_tier             = "Standard"
    account_replication_type = "LRS"
  }
}

# Linux VM module
module "vmlinux-n01581665" {
  source = "./modules/vmlinux-n01581665"

  tags = local.assignment01_tags

  rg-info = {
    name     = module.rgroup-n01581665.rg-n01581665-info.name
    location = module.rgroup-n01581665.rg-n01581665-info.location
  }

  instance_count = 3

  n01581665-vmlinux-info = {
    name          = "n01581665-linux"
    computer_name = "n01581665-computer_name"
    size          = "Standard_B1s"

    storage_account_uri = module.common-n01581665.storage_account-primary_blob_endpoint

    admin_ssh_key = {
      admin_username = "n01581665-kartik"
      public_key     = "/mnt/c/Users/Kartik/.ssh/id_rsa.pub"
    }

    private_key = "/mnt/c/Users/Kartik/.ssh/id_rsa.pub"

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

  n01581665-vmlinux-avs-info = {
    name                         = "n01581665-linux-avs"
    platform_update_domain_count = "4"
    platform_fault_domain_count  = "2"
  }

  n01581665-vmlinux-nic = {
    ip_configuration = {
      subnet_id                     = module.network-n01581665.n01581665-SUBNET.id
      private_ip_address_allocation = "Dynamic"
    }
  }

  n01581665-vmlinux-pip = {
    allocation_method       = "Dynamic"
    idle_timeout_in_minutes = "30"
  }

  n01581665-vmlinux-network-watcher = {
    publisher                  = "Microsoft.Azure.NetworkWatcher"
    type                       = "NetworkWatcherAgentLinux"
    type_handler_version       = "1.0"
    auto_upgrade_minor_version = true

    settings = <<SETTINGS
        {}
    SETTINGS
  }

  n01581665-vmlinux-network-monitor = {
    publisher                  = "Microsoft.Azure.Monitor"
    type                       = "AzureMonitorLinuxAgent"
    type_handler_version       = "1.0"
    auto_upgrade_minor_version = true

    settings = <<SETTINGS
      {}
  SETTINGS

  }
}


# Windows VM module
module "vmwindows-n01581665" {
  source = "./modules/vmwindows-n01581665"

  tags = local.assignment01_tags

  rg-info = {
    name     = module.rgroup-n01581665.rg-n01581665-info.name
    location = module.rgroup-n01581665.rg-n01581665-info.location
  }

  instance_count = 1

  n01581665-vmwindows-info = {
    name           = "n1665-win"
    computer_name  = "n01581665"
    size           = "Standard_B1s"
    admin_username = "n01581665-kartik"
    admin_password = "/mnt/c/Users/Kartik/.ssh/id_rsa.pub"

    winrm_listener_protocol = "Http"

    storage_account_uri = module.common-n01581665.storage_account-primary_blob_endpoint

    os_disk = {
      storage_account_type = "StandardSSD_LRS"
      disk_size_gb         = "128"
      caching              = "ReadWrite"
    }

    source_image_reference = {
      publisher = "MicrosoftWindowsServer"
      offer     = "WindowsServer"
      sku       = "2016-Datacenter"
      version   = "latest"
    }
  }

  n01581665-vmwindows-avs-info = {
    platform_update_domain_count = 1
    platform_fault_domain_count  = 1
  }

  n01581665-vmwindows-nic = {
    ip_configuration = {
      subnet_id                     = module.network-n01581665.n01581665-SUBNET.id
      private_ip_address_allocation = "Dynamic"
    }
  }

  n01581665-vmwindows-pip = {
    allocation_method       = "Dynamic"
    idle_timeout_in_minutes = 30
  }

  n01581665-vmwindows-antimalware = {
    publisher                  = "Microsoft.Azure.Security"
    type                       = "IaaSAntimalware"
    type_handler_version       = "1.3"
    auto_upgrade_minor_version = "true"

    settings = <<SETTINGS
        {}
    SETTINGS
  }
}

# Datadisks for VMs
module "datadisk-n01581665" {
  source = "./modules/datadisk-n01581665"

  tags = local.assignment01_tags

  rg-info = {
    name     = module.rgroup-n01581665.rg-n01581665-info.name
    location = module.rgroup-n01581665.rg-n01581665-info.location
  }

  n01581665-vmlinux-datadisk-info = {
    n01581665-vmlinux-names = module.vmlinux-n01581665.n01581665-vmlinux.hostnames
    total-vms               = 3
    storage_account_type    = "Standard_LRS"
    create_option           = "Empty"
    disk_size_gb            = 10
  }

  n01581665-vmlinux-datadisk-attachment-info = {
    virtual_machine_ids = module.vmlinux-n01581665.n01581665-vmlinux.ids
    lun                 = "0"
    caching             = "ReadWrite"
  }

  n01581665-vmwindows-datadisk-info = {
    n01581665-vmwindows-names = module.vmwindows-n01581665.n01581665-vmwindows.hostnames
    total-vms                 = 1
    storage_account_type      = "Standard_LRS"
    create_option             = "Empty"
    disk_size_gb              = 10
  }

  n01581665-vmwindows-datadisk-attachment-info = {
    virtual_machine_ids = module.vmwindows-n01581665.n01581665-vmwindows.ids
    lun                 = "0"
    caching             = "ReadWrite"
  }
}

# Loadbalancer module
module "loadbalancer-n01581665" {
  source = "./modules/loadbalancer-n01581665"

  tags = local.assignment01_tags

  rg-info = {
    name     = module.rgroup-n01581665.rg-n01581665-info.name
    location = module.rgroup-n01581665.rg-n01581665-info.location
  }

  n01581665-loadbalancer-name = "n01581665-loadbalancer"
  allocation_method           = "Dynamic"

  n01581665-loadbalancer-nic-backend_pool_association-info = {
    count     = 3
    hostnames = module.vmlinux-n01581665.n01581665-vmlinux.hostnames
    nic_ids   = module.vmlinux-n01581665.nic_id
  }

  n01581665-loadbalancer-rules = {
    name                           = "n01581665-loadbalancer-rules"
    protocol                       = "Tcp"
    frontend_port                  = "22"
    backend_port                   = "22"
    frontend_ip_configuration_name = "PublicIPAddress"
  }
}

# Database module
module "database-n01581665" {
  source = "./modules/database-n01581665"

  rg-info = {
    name     = module.rgroup-n01581665.rg-n01581665-info.name
    location = module.rgroup-n01581665.rg-n01581665-info.location
  }

  n01581665-database-server-info = {
    sku_name = "B_Gen5_2"

    storage_mb                   = "5120"
    backup_retention_days        = "7"
    geo_redundant_backup_enabled = "false"
    auto_grow_enabled            = "true"

    administrator_login          = "psqladmin"
    administrator_login_password = "n01581665PSQL@"
    version                      = "9.5"
    ssl_enforcement_enabled      = "true"
  }

  n01581665-database-info = {
    name      = "n01581665-database"
    charset   = "UTF8"
    collation = "English_United States.1252"
  }
}