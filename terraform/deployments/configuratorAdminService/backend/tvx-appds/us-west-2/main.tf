terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform-prod"
    key    = "coast/tvx-appds/dataService/configadmin/us-west-2/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "prod-west-configadmin" {
  source                      = "../../../../../modules/dataService"
  instance_type               = "c5.xlarge"
  security_groups             = ["sg-005474c0048d8b6e4", "sg-e5cbb89f", "sg-695f640d", "sg-7fe1a205", "sg-010cc992f46ab6f33"]
  aws_region                  = "us-west-2"
  single_subnet_instance_count = 1
  user_data                   = "${file("userdata_west")}"
  vpc_id                      = "vpc-74695511"
  subnet_id                   = "subnet-f2feef97"
  comcast_application_name    = "xreconfiguratoradmin"
  comcast_application_role    = "xcfgui"
  comcast_application_env     = "prod"
  comcast_iop_appid           = "31865"
  comcast_service_name        = "xcfgui"
  name                        = "xvpsvc"
  domain                      = "appds.xcal.tv"
  key_pair                    = "coast-master-key-prod"
  data_center                 = "aw"
}

#For PROD, standard UI host count is 1.
#Workspace naming format is xreconfigadmin_(version)_aw_(iteration number)
