terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform-prod"
    key    = "coast/ccp-prod/dataService/adsadmin/ccp-ho-az1/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "ccp-prod-ho-adsadmin" {
  access_token             = var.access_token
  source                   = "../../../../../modules/dataServiceCCP"

  deployment_count         = 1
  account_id               = "e0490ad5-59af-4a6c-a0b2-6e88167cfca3"
  account_name             = "xvp_cs_ccp_ads-prod"
  comcast_application_name = "ads"
  comcast_application_role = "adsui"
  comcast_application_env  = "prod"
  region                   = "hillsboro"
  data_center              = "ph"
  az                       = "az1"
  description              = "ADS Admin 2.56.16 - PROD"
  catalog_item_name        = "Linux Custom"
  instance_count           = 1
  flavor                   = "CC.4cpu-8GB"
  bootcapacity             = 50
  tenant                   = "xvp_capitalservices_ccp_prod_set1"
  rail                     = "protected"
  cmi                      = var.cmi
  ipv                      = "IPv4_IPv6"
  devhub_appid             = 31851
  full_env                 = "prod"
  resource_type            = "web"

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
                ansible-playbook -vvvv --connection=local --inventory "127.0.0.1," appdiscoveryAdminService.yml --extra-vars "env_type=prod datacenter=ph service_listen_port_ssl=443 java_package=java-1.8.0-openjdk.x86_64 run_number=b" > local_2nd_ansible_run.txt
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
