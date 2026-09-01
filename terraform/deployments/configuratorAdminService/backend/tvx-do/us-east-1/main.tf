terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform"
    key    = "coast/tvx-do/dataService/configadmin/us-east-1/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "ci-east-configadmin" {
  source                      = "../../../../../modules/dataService"
  instance_type               = "c5.xlarge"
  security_groups             = ["sg-88b78bed", "sg-a8e1eccd", "sg-74b49806"]
  aws_region                  = "us-east-1"
  single_subnet_instance_count = 2
  user_data                   = "${file("userdata_east")}"
  vpc_id                      = "vpc-0cb21169"
  subnet_id                   = "subnet-e42182bd"
  comcast_application_name    = "xreconfiguratoradmin"
  comcast_application_role    = "xcfgui"
  comcast_application_env     = "ci"
  comcast_iop_appid           = "31865"
  comcast_service_name        = "xcfgui"
  name                        = "xvpsvc"
  domain                      = "do.xcal.tv"
  key_pair                    = "coast-master-key-dev"
  data_center                 = "ae"
}

#For CI, standard UI host count is 2. 1 is for CI, 1 is for QA
#Workspace naming format is xreconfigadmin_(version)_de_(iteration number)
