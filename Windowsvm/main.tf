resource "null_resource" "decrypt_secret" {
  provisioner "local-exec" (
    command = "powershell. exe -File ../decrypt_secret.ps1"
  }
}  
data "azurerm_virtual_network" "vnet" {
for_each = { for rg in var.vm_list: rg-vm_name →> rg }
name= each.value.virtual_network_name
resource group_name = each.value.rg_net_name
}
data "azurerm _subnet" "az_subnet" {
for_each             = { for rg in var.vm_list: rgvm_name →> rg }
name                 = each.value.subnet
virtual_network_name = each.value.virtual_network_name
resource_group_name  = each.value.rg_vnet_name
}

resource "azurerm_network_interface" "az_nic" {
for_each    = { for rg in var.vm_list: rg.vm_name => rg }
name        = "${each. value. vm_name}-nic"
location    = each.value.rg_location
resource_group_name = each.value.rg_name

ip_configuration {
    name = each.value.vm_name 
    subnet_id = data.azurerm_subnet.az_subnet[each.key].id
     private_ip_address_allocation = "Dynamic"
     }
}

resource "azurerm windows_virtual machine" "windows_vm" {
for_each = { for rg in var.vm_list: rg-vm_name => rg }

resource_group_name = each.value.rg_name
location           = each. value.rg_ location
name               = each.value. vm_name
size               = each.value.vm_size
admin_username = each. value. admin_username
admin_password = each. value.admin_password
network_interface_ids = [azurerm_network_interface.az_nic[each.key]-id]
os_disk {
caching           = "ReadWrite"
storage_account_type = each.value.storage_account_type
}
source_image_id - each.value.source_image_id
# source_image_reference {
# publisher = "MicrosoftWindowsServer"
offer = "WindowsServer"
# sku = "2016-Datacenter"
# version = "latest"
# }
tags = each.value.tags

}

resource "azurerm_virtual_machine_extension" "vm_domain_join" {
for_each  = { for rg in var.vm_list: rg-vm name => rg }
name = "${each.value.vm_name}-domainjoin"
depends_on = [azurerm_windows_virtual_machine.windows_vm]
virtual_machine_id =azure_machine.windows_vm[each.key].id
publisher = "Microsoft Compute"
type  = "JsonADDomainExtension"
type_handler_version = "1.3"

settings = <<SETTINGS
  {
  "Name" : "${var-domain}"
  "OUPath": "${var-oupath}",
  "User": "${var-domainadmin)"
  "Restart": "true"
  "Options": "3"
  ｝
SETTINGS 

protected_ settings = <<PROTECTED_SETTINGS

"Password": "${var.domainpassword}"
  }
PROTECTED_SETTINGS
}

resource "azurerm_virtual_machine_extension" "adduser" {
   for_each = { for rg in var.vm_list: rg.vm_name => rg }

   name = each.value.vm_name
   depends_on = [azurerm_windows_virtual_machine.windows_vm, azurerm_virtual_machine_extension.vm_domain_join] 
   virtual_machine_id= azurerm_windows_virtual_machine.windows_vm[each.key]-id 
   publisher = "Microsoft. Compute"
   type = "CustomScriptExtension"
type_handler_version = "1.9"
I
protected_ settings = <<SETTINGS
｛
"commandToExecute": "powershell.exe -command Add-LocalGroupMember -Group 'Remote Desktop Users' -Member ${var-domainuser]"
}
SETTINGS

}

