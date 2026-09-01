terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform-prod"
    key    = "coast/tvx-ingrid-adproxy/dataService/blueocean/us-east-2/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "prod-ohio-blueocean" {
  source                       = "../../../../../modules/dataServiceWProfile"
  instance_type                = "c5.xlarge"
  security_groups              = ["sg-019fa2459bfabcb15", "sg-0d4876ecd3a8d85d3", "sg-0b009c3bcd4c2201b", "sg-0718110706417b9bb"]
  aws_region                   = "us-east-2"
  single_subnet_instance_count = 18
  user_data                    = "${file("userdata_ohio_prod")}"
  vpc_id                       = "vpc-0dc2bb57a8fde711a"
  subnet_id                    = "subnet-0a016881ca5d005b5"
  comcast_application_name     = "blueocean"
  comcast_application_role     = "blueocean"
  comcast_application_env      = "prod"
  comcast_iop_appid            = "67699"
  domain                       = "iap.xcal.tv"
  key_pair                     = "iap-ohio"
  data_center                  = "oh"
  termination_protection       = "false"
  name                         = "tvxblo"
  iam_instance_profile         = "CustomerManagedBasic_TaggingRole"
  aws_profile                  = "tvx-ingrid-adproxy_acct_02112025"
}

#For PROD, standard DS host count is 18.
#Workspace naming format is blueocean_(version)_ao_(iteration number)