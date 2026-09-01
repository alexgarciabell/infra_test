terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform"
    key    = "coast/tvx-do/dataService/configadmin/us-west-2/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "ci-west-configadmin" {
  source                      = "../../../../../modules/dataService"
  instance_type               = "c5.xlarge"
  security_groups             = ["sg-f57d2d91", "sg-28e5374f", "sg-d8da89a5"]
  aws_region                  = "us-west-2"
  single_subnet_instance_count = 2
  user_data                   = "${file("userdata_west")}"
  vpc_id                      = "vpc-ffc0399a"
  subnet_id                   = "subnet-66fb3103"
  comcast_application_name    = "xreconfiguratoradmin"
  comcast_application_role    = "xcfgui"
  comcast_application_env     = "ci"
  comcast_iop_appid           = "31865"
  comcast_service_name        = "xcfgui"
  name                        = "xvpsvc"
  domain                      = "do.xcal.tv"
  key_pair                    = "coast-master-key-dev"
  data_center                 = "aw"
}

#For CI, standard UI host count is 2. 1 is for CI, 1 is for QA
#Workspace naming format is xreconfigadmin_(version)_dw_(iteration number)
