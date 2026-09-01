terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform-prod"
    key    = "coast/tvx-appds/dataService/adsadmin/us-east-1/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "prod-east-adsadmin" {
  source                      = "../../../../../modules/dataService"
  instance_type               = "c5.xlarge"
  security_groups             = ["sg-39f23949", "sg-996f84e0", "sg-b50adbcf", "sg-096aa2960f02ad591"]
  aws_region                  = "us-east-1"
  single_subnet_instance_count = 1
  user_data                   = "${file("userdata_east")}"
  vpc_id                      = "vpc-08b9236c"
  subnet_id                   = "subnet-da41b882"
  comcast_application_name    = "adsadmin"
  comcast_application_role    = "adsadmin"
  comcast_application_env     = "prod"
  comcast_service_name        = "adsui"
  comcast_iop_appid           = "31851"
  domain                      = "appds.xcal.tv"
  key_pair                    = "coast-master-key-prod"
  data_center                 = "ae"
}

#For PROD, standard UI host count is 1.
#Workspace naming format is adsadmin_(version)_ae_(iteration number)