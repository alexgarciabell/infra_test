terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform"
    key    = "coast/tvx-do/dataService/adsds/us-west-2/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "ci-west-adsds" {
  source                      = "../../../../../modules/dataService"
  instance_type               = "c5.xlarge"
  security_groups             = ["sg-f57d2d91", "sg-28e5374f"]
  aws_region                  = "us-west-2"
  single_subnet_instance_count = 3
  user_data                   = "${file("userdata_west")}"
  vpc_id                      = "vpc-ffc0399a"
  subnet_id                   = "subnet-6bb9b12d"
  comcast_application_name    = "ads"
  comcast_application_role    = "appdiscoveryService"
  comcast_application_env     = "ci"
  comcast_iop_appid           = "31851"
  comcast_service_name        = "adsds"
  domain                      = "do.xcal.tv"
  key_pair                    = "coast-master-key-dev"
  data_center                 = "aw"
}

#For CI, standard DS host count is 3.
#Workspace naming format is adsds_(version)_dw_(iteration number)
#Instance Type was originally c5.2xlarge. Now converting to c5.xlarge.