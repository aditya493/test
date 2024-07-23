data "azurerm Virtual network" "vnet" f
_network" "vnet"
You, 2 months ago • terraform code
2
for_each
= t for rg in var.vm_list: rg.vm_name => rg }
name
= each. value.virtual_network_name
4
5
resource_group_name = each.value.rg_vnet_name
6
data
"azurerm_subnet" "az_subnet"
7
for_each
8
= { for rg in var.vm_list: rg.vm_name →> rg }
name
=
each.value.subnet
9
virtual_network.
name
each. value.virtual
_network_name
10
resource_group_name
＝
11
each.value.rg_vnet_name
12
13
resource "azurerm network interface" "az_nic" {
14
for_each
= { for rg in var.vm_list : rg.vm_name => rg }
15
= "${each. value.vm_name}-nic"
16
location
= each.value.rg_location
17
resource_group_name = each.value.rg_name
18
19
20
21
22
ip_configuration {
name
= each.value.vm name
subnet_id
= data.azurerm_subnet.az_subnet[each.key].id
private_ip_address_allocation = "Dynamic"
23
｝
24
}
25
26
27
resource "azurerm windows_virtual _machine" "windows_vm" for_each = { for rg in var.vm_list: rg.vm_name →>

resource_ group_name location name size admin_username admin_password network_interface_ids =
os_disk {
caching
= each.value.rg name = each.value.rg_location = each.value.vm name = each.value.vm size each.value.admin_username
each.value.admin_password [azurerm_network_interface.az_nic[each.key].id]
= "Readwrite"