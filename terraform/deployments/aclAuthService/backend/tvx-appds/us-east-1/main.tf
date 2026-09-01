terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform-prod"
    key    = "coast/tvx-appds/dataService/aclauth/us-east-1/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "prod-east-aclauth" {
  source                      = "../../../../../modules/dataService"
  instance_type               = "m5.large"
  security_groups             = ["sg-996f84e0", "sg-2c450859", "sg-021d7a7b", "sg-7a518000", "sg-0c202da1cd96e3541"]
  aws_region                  = "us-east-1"
  single_subnet_instance_count = 2
  user_data                   = "${file("userdata_east")}"
  vpc_id                      = "vpc-08b9236c"
  subnet_id                   = "subnet-da41b882"
  comcast_application_name    = "aclauth"
  comcast_application_role    = "aclAuthService"
  comcast_application_env     = "prod"
  comcast_service_name        = "aclauth"
  comcast_iop_appid           = "9ea98e0d1b8d5450be6dea866e4bcbd2"
  name                        = "xvpsvc"
  domain                      = "appds.xcal.tv"
  key_pair                    = "coast-master-key-prod"
  data_center                 = "ae"
}

#For PROD, standard host count is 2, until XCONF Admin stops using ACL Auth.
#Workspace naming format is aclauth_(version)_ae_(iteration number)
#1 host will be used for normal, 1 will be used for XCONF Admin which needs to be manually modified.
