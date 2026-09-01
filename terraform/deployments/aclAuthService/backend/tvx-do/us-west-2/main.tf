terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform"
    key    = "coast/tvx-do/dataService/aclauth/us-west-2/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "ci-west-aclauth" {
  source                      = "../../../../../modules/dataService"
  instance_type               = "m5.large"
  security_groups             = ["sg-d8da89a5", "sg-0b999176"]
  aws_region                  = "us-west-2"
  single_subnet_instance_count = 2
  user_data                   = "${file("userdata_west")}"
  vpc_id                      = "vpc-ffc0399a"
  subnet_id                   = "subnet-6bb9b12d"
  comcast_application_name    = "aclauth"
  comcast_application_role    = "aclAuthService"
  comcast_application_env     = "ci"
  comcast_service_name        = "aclauth"
  comcast_iop_appid           = "9ea98e0d1b8d5450be6dea866e4bcbd2"
  name                        = "xvpsvc"
  domain                      = "do.xcal.tv"
  key_pair                    = "coast-master-key-dev"
  data_center                 = "aw"
}

#For CI, standard host count is 2, until XCONF Admin stops using ACL Auth.
#Workspace naming format is aclauth_(version)_dw_(iteration number)
#1 host will be used for normal, 1 will be used for XCONF Admin which needs to be manually modified.
