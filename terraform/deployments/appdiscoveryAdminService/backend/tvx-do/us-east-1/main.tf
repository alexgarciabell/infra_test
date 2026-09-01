terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform"
    key    = "coast/tvx-do/dataService/adsadmin/us-east-1/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "ci-east-adsadmin" {
  source                      = "../../../../../modules/dataService"
  instance_type               = "c5.xlarge"
  security_groups             = ["sg-88b78bed", "sg-a8e1eccd", "sg-f1be0b8d", "sg-74b49806"]
  aws_region                  = "us-east-1"
  single_subnet_instance_count = 2
  user_data                   = "${file("userdata_east")}"
  vpc_id                      = "vpc-0cb21169"
  subnet_id                   = "subnet-5ebb7475"
  comcast_application_name    = "adsadmin"
  comcast_application_role    = "adsadmin"
  comcast_application_env     = "ci"
  comcast_service_name        = "adsui"
  comcast_iop_appid           = "31851"
  domain                      = "do.xcal.tv"
  key_pair                    = "coast-master-key-dev"
  data_center                 = "ae"
}

#For CI, standard UI host count is 2.
#Workspace naming format is adsadmin_(version)_de_(iteration number)
