# Resource group
output "rg-n01581665-name" {
  value = module.rgroup-n01581665.rg-n01581665-info.name
}

# Network resources
output "n01581665-VNET-name" {
  value = module.network-n01581665.n01581665-VNET-name
}

output "n01581665-SUBNET" {
  value = module.network-n01581665.n01581665-SUBNET
}

# Common resources
output "log_analytics_workspace-name" {
  value = module.common-n01581665.log_analytics_workspace-name
}

output "recovery_services_vault-name" {
  value = module.common-n01581665.recovery_services_vault-name
}

output "storage_account-name" {
  value = module.common-n01581665.storage_account-name
}

# Virtual Machine: Linux resources
output "n01581665-vmlinux-hostname" {
  value = module.vmlinux-n01581665.n01581665-vmlinux
}

output "n01581665-vmlinux-FQDN" {
  value = module.vmlinux-n01581665.n01581665-vmlinux-FQDN
}

output "n01581665-vmlinux-private-ip" {
  value = module.vmlinux-n01581665.n01581665-vmlinux-private-ip
}

output "n01581665-vmlinux-public-ip" {
  value = module.vmlinux-n01581665.n01581665-vmlinux-public-ip
}

# Virtual Machine: Windows resources
output "n01581665-vmwindows-hostname" {
  value = module.vmwindows-n01581665.n01581665-vmwindows
}

output "n01581665-vmwindows-FQDN" {
  value = module.vmwindows-n01581665.n01581665-vmwindows-FQDN
}

output "n01581665-vmwindows-private-ip" {
  value = module.vmwindows-n01581665.n01581665-vmwindows-private-ip
}

output "n01581665-vmwindows-public-ip" {
  value = module.vmwindows-n01581665.n01581665-vmwindows-public-ip
}

# loadbalancer
output "n01581665-loadbalancer-name" {
  value = module.loadbalancer-n01581665.n01581665-loadbalancer-name
}

# Database
output "n01581665-database" {
  value = module.database-n01581665.n01581665-database-name
}