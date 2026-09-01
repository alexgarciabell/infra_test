terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform-prod"
    key    = "coast/tvx-appds/dataService/adsds/us-west-2/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "prod-west-adsds" {
  source                      = "../../../../../modules/dataService"
  instance_type               = "c5.xlarge"
  security_groups             = ["sg-e5cbb89f", "sg-0ca7f62adea8b092f"]
  aws_region                  = "us-west-2"
  single_subnet_instance_count = 40
  user_data                   = "${file("userdata_west")}"
  vpc_id                      = "vpc-74695511"
  subnet_id                   = "subnet-d5286a8c"
  comcast_application_name    = "ads"
  comcast_application_role    = "appdiscoveryService"
  comcast_application_env     = "prod"
  comcast_iop_appid           = "31851"
  comcast_service_name        = "adsds"
  domain                      = "appds.xcal.tv"
  key_pair                    = "coast-master-key-prod"
  data_center                 = "aw"
}

#For PROD, standard DS host count is 40.
#Workspace naming format is adsds_(version)_ae_(iteration number)
#Instance Type was originally c5.2xlarge. Now converting to c5.xlarge.