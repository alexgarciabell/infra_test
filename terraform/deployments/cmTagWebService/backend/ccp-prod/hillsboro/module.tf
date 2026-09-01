terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform-prod"
    key    = "coast/ccp-prod/dataService/tagui/ccp-ho-az1/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "ccp-prod-ho-tagui" {
  access_token             = var.access_token
  source                   = "../../../../../modules/dataServiceCCP"

  deployment_count         = 1
  account_id               = "e0490ad5-59af-4a6c-a0b2-6e88167cfca3"
  account_name             = "xvp_cs_ccp_ads-prod"
  comcast_application_name = "taggingservice"
  comcast_application_role = "tagui"
  comcast_application_env  = "prod"
  region                   = "hillsboro"
  data_center              = "ph"
  az                       = "az1"
  description              = "Tagging Portal version 1.4.1 - PROD (New SSL Cert)"
  catalog_item_name        = "Linux Custom"
  instance_count           = 1
  flavor                   = "CC.4cpu-8GB"
  bootcapacity             = 50
  tenant                   = "xvp_capitalservices_ccp_prod_set1"
  rail                     = "protected"
  cmi                      = var.cmi
  ipv                      = "IPv4_IPv6"
  devhub_appid             = 31921
  full_env                 = "prod"
  resource_type            = "web"
  role_id                  = var.role_id
  secret_id                = var.secret_id

  cloud_init = <<-EOF
      #cloud-config
      cloud_final_modules:
          - [scripts-user, always]
      runcmd:
          - |
            TRIGGER_FILE="/tmp/packer-provisioner-ansible-local/trigger-file"
            if [ -f TRIGGER_FILE ]; then
                echo "Running user-data ..."
                cd /tmp/packer-provisioner-ansible-local
                cd "$(\ls -1dt ./*/ | head -n 1)"
                ansible-playbook -vvvv --connection=local --inventory "127.0.0.1," cmTagWebService.yml --extra-vars "env_type=prod datacenter=ph run_number=b role_id=${var.role_id} secret_id=${var.secret_id}" > local_2nd_ansible_run.txt
                # Extend boot disk to have access to full capacity
                growpart /dev/sda 2
                pvresize /dev/sda2
                lvextend -rl +95%FREE /dev/$(vgs --noheadings | awk '{print $1}')/root
                rm TRIGGER_FILE
            else
                echo "Skipping user-data execution"
                sudo touch "TRIGGER_FILE"
                echo "trigger file created"
            fi
        EOF
}
