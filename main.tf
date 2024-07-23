/*
module "az_resource_group" {
   source           =./modules/resourcegroup"
   resource_groups  = var.resource_groups


*/
module "az_windows_vm" {
   source    = ./modules/windowsvm"
   vm_list   = var.vm_list
   domain = var.domain
   domainuser = var.domainuser
   domainpassword = var.domainpassword
   oupath = var.oupath
}   

/*
module "az_linux_vm" {
   source =".Modules/linuxvm"
   vm_list = var.vm_list
   domain= var.domain
   domainadmin = var.domainadmin 
   domainuser = var.domainuser
   domainpassword= var.domainpassword
   oupath = var.oupath
}

*/