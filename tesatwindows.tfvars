subscription_id = "58a62efd-fc92-4623-8821-d743df1e8c45"
domains = ["itint.com", "anotherdomain.com"]
domainadmins = ["svc_ansible_win@itint.com", "svc_ansible_win@anotherdomain.com"]
domainpasswords = [";Z@KqZ^A1fXq' DjQN%m", ";Z@KqZ^A1fXq' DjQN%m"]
domainusers = ["lnkjenkinsdevops@itint.com", "lnkjenkinsdevops@anotherdomain.com"]
oupaths = ["OU=SRV - vRealize,DC=ITINT,DC=com", "OU=SRV - vRealize,DC=ANOTHER,DC=com"]


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
