terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform-prod"
    key    = "coast/tvx-appds/dataService/adsds/us-east-1/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "prod-east-adsds" {
  source                      = "../../../../../modules/dataService"
  instance_type               = "c5.xlarge"
  security_groups             = ["sg-39f23949", "sg-081a197d79f6858d5"]
  aws_region                  = "us-east-1"
  single_subnet_instance_count = 40
  user_data                   = "${file("userdata_east")}"
  vpc_id                      = "vpc-08b9236c"
  subnet_id                   = "subnet-da41b882"
  comcast_application_name    = "ads"
  comcast_application_role    = "appdiscoveryService"
  comcast_application_env     = "prod"
  comcast_iop_appid           = "31851"
  comcast_service_name        = "adsds"
  domain                      = "appds.xcal.tv"
  key_pair                    = "coast-master-key-prod"
  data_center                 = "ae"
}

#For PROD, standard DS host count is 40.
#Workspace naming format is adsds_(version)_ae_(iteration number)
#Instance Type was originally c5.2xlarge. Now converting to c5.xlarge.