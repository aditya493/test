/*
module "az_resource_group" {
   source           =./modules/resourcegroup"
   resource_groups  = var.resource_groups


*/
module "az_windows_vm" {
  source = "./Modules/windowsvm"
  subscription_id = var.subscription_id

  for_each = { for idx, domain in toset(var.domains) : domain => idx }

  domain = each.key
  domainadmin = element(var.domainadmins, each.value)
  domainpassword = element(var.domainpasswords, each.value)
  domainuser = element(var.domainusers, each.value)
  oupath = element(var.oupaths, each.value)
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
