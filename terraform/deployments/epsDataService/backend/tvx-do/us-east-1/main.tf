terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform"
    key    = "coast/tvx-do/dataService/epsds/us-east-1/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "ci-east-epsds" {
  source                      = "../../../../../modules/dataService"
  instance_type               = "c5.xlarge"
  security_groups             = ["sg-a8e1eccd", "sg-49fcba2c", "sg-88b78bed"]
  aws_region                  = "us-east-1"
  single_subnet_instance_count = 3
  user_data                   = "${file("userdata_east")}"
  vpc_id                      = "vpc-0cb21169"
  subnet_id                   = "subnet-5ebb7475"
  comcast_application_name    = "eps"
  comcast_application_role    = "epsds"
  comcast_application_env     = "ci"
  comcast_iop_appid           = "31858"
  comcast_service_name        = "epsds"
  domain                      = "do.xcal.tv"
  key_pair                    = "coast-master-key-dev"
  data_center                 = "ae"
  role_id                     = var.role_id
  secret_id                   = var.secret_id
}

#For CI, standard DS host count is 3.
#Workspace naming format is epsds_(version)_de_(iteration number)