subscription_id = "617d22e1-cf4e-4f99-ba24-7de58e4c6e00"
domain          = "cbs.fiserv.net"
domainadmin     ="djoin@cbs.fiserv.net"
domainpassword  ="4T2U==x-e%H2ab(R"
domainuser      = "adminwl@cbs.fiserv.net"
oupath          ="OU=vRealize,OU=Servers,OU=Virtual Machines,OU=ORL,OU=US,OU=CBS,DC=cbs,DC=fiserv,DC=net"

vm_list =[
    {
     rg_name = "UAID-F3627_Communicator-International"
     rg_vnet_name= "n-rg-emeasignature-network"
     rg_location = "centralus"
     virtual_network_name = "usce-n-vnet-emeasignature-01"
     subnet = "usce-n-subnet-emeasignature-01"
     vm_name = "l7wdtest20001"
     vm_size = "Standard_F2"
     storage_account_type = "StandardSSD_LRS"
     source_image_id = "/subscriptions/fe76ae45-ee1b-4888-a44e-e8f0904fcdca/resourceGroups/image-build-rg/providers/Microsoft.Compute/galleries/FiservPublished/images/Fiserv_Win2019/versions/latest"
     admin_username        =    "adminuser"
     admin_password        =    "P@$$w0rd1234!@."
     rg_name               =    "APM0004414_ConnecedTeller"
     vm_name               =    "l7wd2ctsdev0002"
     tags = {
        "Owner"     =   "test1"
        "UAID#"     =   "F3191"
        "APM#"      =   "APM0004414"
        "createdby" =   "terraform"
    }
  },
]