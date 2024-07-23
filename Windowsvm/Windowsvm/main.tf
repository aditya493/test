resource “null_resource” “decrypt_secret{
  provisioner “local-exec” {
    command  =”powershell.exe -File ../decrypt_secret.ps1”
  }
}
data “azure_virtual_network” “vnet” {
   for_each            = { for rg in var.vm_list : rg.vm_name => rg }
   name                = each.value.virtual_network_name
   resource_group_name = each.value.rg_vnet_name
}

data “azurevm_subnet” “az_subnet” {
  for_each              = { for rg in var.vm_list : rg.vm_name => rg }
  name                  = each.value.subnet
  virtual_network_name  = each.value.virtual_network_name
  resource_group_name   = each.value.rg_vnet_name
}

data “azurevm_network_interface” “az_nic” {
   for_each            = { for rg in var.vm_list :rg.vm_name => rg}
   name                = “${each.value.vm_name}-nic”
   location            = each.value.rg_location
   resource_group_name = each.value.rg_name

ip_configuration {
    name                           = each.value.vm_name
    subnet_id                      = data.azurerm_subnet.az_subnet[each.key].id
    private__ip_address_allocation = “Dynamic”
   }
}

resource  “azurerm_windows_virtual_machine””windows_vm” {
   for_each = { for rg in var.vm_list : rg.vm_name => rg }

    resource_group_name = each.value.rg_name
    location= each.value.rg_location
    name = each.value.vm_name
    size = each.value.vm_size
    admin_username = each.value.admin_username
    admin_password = each.value.admin_password
    network_interface_ids = [azurerm_network_interface.az_nic[each.key].id]
    os_disk {
       caching.   = “ Readwrite”
       storage_account_type =  each.value.storage_account_type
}
source_image_id = each.value.source_image_id






tags = each.value.tags

}


resource “azurerm_virtual_machine_extension” “ vm_domain_join” {
    for_each = { for rg in var.vm_list ; rg.vm_name => rg }
    name = “${each.value.vm_name}-domainjoin”
    depends_on = [azurerm_windows_virtual_machine.windows_vm]
    virtual_machine_id = azurerm_windows_virtual_machine.windows_wm[each.key].id
    publisher =”Microsoft.Compute”
    type = “JsonADDdomainExtension”
    type_handler_version = “1.3”

setting = << SETTINGS
    {
    “Name” : “${var.domain}”,
    “OUPath” : “${var.oupath}”,
    “User” : “${var.domainadmin}”,
    “Restart”: “true”,
    “Options” :”3”
}
SETTINGS

  Protected_settings = <<PROTECTED_SETTINGS
    {
           “Password” :”${var.domainpassword}”

PROTECTED_SETTINGS
      }

Resource “azurerm_virtual_machine_extension” “adduser” {
  for_each ={ for rg in var.vm_list : rg.vm_name => rg}

name  = each.value.vm_name
depends_on = [azure_windows_virtual_machine.windows_vm,azurerm_virtual_machine_extension.vm_domain_join]
virtual_machine_id = azurerm_windows_virtual_machine.windows_vm[each.key].id
publisher = “Microsoft.compute”
type = “CustomScriptExtension”
type_handler_version =”1.9”

protected_settings = << SETTINGS
{
   “commandToExecute”: “powershell.exe – command Add-LocalGroupMember -Group ‘Remote Desktop users’ -Member ${var.domainuser} “
}
SETTINGS

}
