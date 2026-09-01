terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform"
    key    = "coast/tvx-do/dataService/adsadmin/us-west-2/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "ci-west-adsadmin" {
  source                      = "../../../../../modules/dataService"
  instance_type               = "c5.xlarge"
  security_groups             = ["sg-f57d2d91", "sg-28e5374f", "sg-d8da89a5"]
  aws_region                  = "us-west-2"
  single_subnet_instance_count = 1
  user_data                   = "${file("userdata_west")}"
  vpc_id                      = "vpc-ffc0399a"
  subnet_id                   = "subnet-6bb9b12d"
  comcast_application_name    = "adsadmin"
  comcast_application_role    = "adsadmin"
  comcast_application_env     = "ci"
  comcast_service_name        = "adsui"
  comcast_iop_appid           = "31851"
  domain                      = "do.xcal.tv"
  key_pair                    = "coast-master-key-dev"
  data_center                 = "aw"
}

#For CI, standard UI host count is 2.
#Workspace naming format is adsadmin_(version)_dw_(iteration number)