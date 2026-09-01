terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform-prod"
    key    = "coast/tvx-appds/dataService/aclauth/us-west-2/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "prod-west-aclauth" {
  source                      = "../../../../../modules/dataService"
  instance_type               = "m5.large"
  security_groups             = ["sg-695f640d", "sg-29f5f44f", "sg-50ab4a37", "sg-d905aaa5", "sg-004d349a5584d92e2"]
  aws_region                  = "us-west-2"
  single_subnet_instance_count = 2
  user_data                   = "${file("userdata_west")}"
  vpc_id                      = "vpc-74695511"
  subnet_id                   = "subnet-d5286a8c"
  comcast_application_name    = "aclauth"
  comcast_application_role    = "aclAuthService"
  comcast_application_env     = "prod"
  comcast_service_name        = "aclauth"
  comcast_iop_appid           = "9ea98e0d1b8d5450be6dea866e4bcbd2"
  name                        = "xvpsvc"
  domain                      = "appds.xcal.tv"
  key_pair                    = "coast-master-key-prod"
  data_center                 = "aw"
}

#For PROD, standard host count is 2, until XCONF Admin stops using ACL Auth.
#Workspace naming format is aclauth_(version)_aw_(iteration number)
#1 host will be used for normal, 1 will be used for XCONF Admin which needs to be manually modified.
