terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform"
    key    = "coast/tvx-do/dataService/aclauth/us-east-1/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "ci-east-aclauth" {
  source                      = "../../../../../modules/dataService"
  instance_type               = "m5.large"
  security_groups             = ["sg-260bf253", "sg-a8e1eccd", "sg-74b49806"]
  aws_region                  = "us-east-1"
  single_subnet_instance_count = 2
  user_data                   = "${file("userdata_east")}"
  vpc_id                      = "vpc-0cb21169"
  subnet_id                   = "subnet-5ebb7475"
  comcast_application_name    = "aclauth"
  comcast_application_role    = "aclAuthService"
  comcast_application_env     = "ci"
  comcast_service_name        = "aclauth"
  comcast_iop_appid           = "9ea98e0d1b8d5450be6dea866e4bcbd2"
  name                        = "xvpsvc"
  domain                      = "do.xcal.tv"
  key_pair                    = "coast-master-key-dev"
  data_center                 = "ae"
}

#For CI, standard host count is 2, until XCONF Admin stops using ACL Auth.
#Workspace naming format is aclauth_(version)_de_(iteration number)
#1 host will be used for normal, 1 will be used for XCONF Admin which needs to be manually modified.
