terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform-prod"
    key    = "coast/tvx-ingrid-adproxy/dataService/blueocean/us-west-2/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "prod-west-blueocean" {
  source                       = "../../../../../modules/dataServiceWProfile"
  instance_type                = "c5.xlarge"
  security_groups              = ["sg-0cfb6afaf3b8e9d42", "sg-045561478af475b9f", "sg-02464c313cf03993f", "sg-06cce4398cb0d7d8e"]
  aws_region                   = "us-west-2"
  single_subnet_instance_count = 18
  user_data                    = "${file("userdata_west_prod")}"
  vpc_id                       = "vpc-0d37635f180093974"
  subnet_id                    = "subnet-0c347b3111632d8e1"
  comcast_application_name     = "blueocean"
  comcast_application_role     = "blueocean"
  comcast_application_env      = "prod"
  comcast_iop_appid            = "67699"
  domain                       = "iap.xcal.tv"
  key_pair                     = "iap-oregon"
  data_center                  = "aw"
  termination_protection       = "false"
  name                         = "tvxblo"
  iam_instance_profile         = "CustomerManagedBasic_TaggingRole"
  aws_profile                  = "tvx-ingrid-adproxy_acct_02112025"
}

#For PROD, standard DS host count is 18.
#Workspace naming format is blueocean_(version)_aw_(iteration number)