resource "null_resource" "vmlinux-n01579649-provisioner-linux" {
    for_each = local.instances

    provisioner "remote-exec" {
        inline = [ "echo Hostname: $(hostname)" ]
    }

    connection {
      type = "ssh"
      user = var.n01579649-vmlinux-info.admin_ssh_key.admin_username
    #   host        = azurerm_public_ip.n01579649-pip[each.key].ip_address
    host = azurerm_linux_virtual_machine.n01579649-vmlinux[each.key].public_ip_address
      private_key = file(var.n01579649-vmlinux-info.private_key)
    }

    depends_on = [ azurerm_linux_virtual_machine.n01579649-vmlinux ]
}