resource "null_resource" "vmlinux-n01581665-provisioner-linux" {
    for_each = local.instances

    # provisioner "remote-exec" {
    #     inline = [ "echo Hostname: $(hostname)" ]
    # }

    provisioner "local-exec" {
      command = "ansible-playbook -i /mnt/d/Projects/Terraform_humber_project/Tearraform_project_n01581665/ansible/hosts /mnt/d/Projects/Terraform_humber_project/Tearraform_project_n01581665/ansible/n01581665-playbook.yaml"

    }

    connection {
      type = "ssh"
      user = var.n01581665-vmlinux-info.admin_ssh_key.admin_username
      host = azurerm_linux_virtual_machine.n01581665-vmlinux[each.key].public_ip_address
      private_key = file(var.n01581665-vmlinux-info.private_key)
    }

    depends_on = [ azurerm_linux_virtual_machine.n01581665-vmlinux ]
}