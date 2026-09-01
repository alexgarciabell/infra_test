terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform"
    key    = "coast/tvx-do/dataService/configds/us-east-1/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "ci-east-configds" {
  source                      = "../../../../../modules/dataService"
  instance_type               = "c5.xlarge"
  security_groups             = ["sg-88b78bed", "sg-a8e1eccd"]
  aws_region                  = "us-east-1"
  single_subnet_instance_count = 3
  user_data                   = "${file("userdata_east")}"
  vpc_id                      = "vpc-0cb21169"
  subnet_id                   = "subnet-5ebb7475"
  comcast_application_name    = "xreconfigurator"
  comcast_application_role    = "xcfgds"
  comcast_application_env     = "ci"
  comcast_iop_appid           = "31865"
  comcast_service_name        = "xcfgds"
  name                        = "xvpsvc"
  domain                      = "do.xcal.tv"
  key_pair                    = "coast-master-key-dev"
  data_center                 = "ae"
}

#For CI, standard DS host count is 3.
#Workspace naming format is xreconfigds_(version)_de_(iteration number)