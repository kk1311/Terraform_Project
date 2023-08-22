# Data-disk for Linux VMs
resource "azurerm_managed_disk" "n01581665-vmlinux-datadisk" {
    resource_group_name = var.rg-info.name
    location = var.rg-info.location

    count = length(var.n01581665-vmlinux-datadisk-info.n01581665-vmlinux-names)
    name = "${var.n01581665-vmlinux-datadisk-info.n01581665-vmlinux-names[count.index]}-datadisk-${format("%d", count.index+1)}"
    storage_account_type = var.n01581665-vmlinux-datadisk-info.storage_account_type
    create_option = var.n01581665-vmlinux-datadisk-info.create_option
    disk_size_gb = var.n01581665-vmlinux-datadisk-info.disk_size_gb

    tags = var.tags
}

resource "azurerm_virtual_machine_data_disk_attachment" "n01581665-vmlinux-datadisk-attachment" {
    count = length(var.n01581665-vmlinux-datadisk-info.n01581665-vmlinux-names)
    managed_disk_id = azurerm_managed_disk.n01581665-vmlinux-datadisk[count.index].id
    virtual_machine_id = var.n01581665-vmlinux-datadisk-attachment-info.virtual_machine_ids[count.index]
    lun = var.n01581665-vmlinux-datadisk-attachment-info.lun
    caching = var.n01581665-vmlinux-datadisk-attachment-info.caching

    depends_on = [ azurerm_managed_disk.n01581665-vmlinux-datadisk ]
}

# Data-disk for Windows VMs
resource "azurerm_managed_disk" "n01581665-vmwindows-datadisk" {
    resource_group_name = var.rg-info.name
    location = var.rg-info.location

    count = length(var.n01581665-vmwindows-datadisk-info.n01581665-vmwindows-names)
    name = "${
        var.n01581665-vmwindows-datadisk-info.n01581665-vmwindows-names[count.index]
    }-datadisk-${format("%d", count.index+1)}"
    storage_account_type = var.n01581665-vmwindows-datadisk-info.storage_account_type
    create_option = var.n01581665-vmwindows-datadisk-info.create_option
    disk_size_gb = var.n01581665-vmwindows-datadisk-info.disk_size_gb
    tags = var.tags
}

resource "azurerm_virtual_machine_data_disk_attachment" "n01581665-vmwindows-datadisk-attachment" {
    count = length(var.n01581665-vmwindows-datadisk-info.n01581665-vmwindows-names)
    managed_disk_id = azurerm_managed_disk.n01581665-vmwindows-datadisk[count.index].id
    virtual_machine_id = var.n01581665-vmwindows-datadisk-attachment-info.virtual_machine_ids[count.index]
    lun = var.n01581665-vmwindows-datadisk-attachment-info.lun
    caching = var.n01581665-vmwindows-datadisk-attachment-info.caching

    depends_on = [ azurerm_managed_disk.n01581665-vmwindows-datadisk ]
}