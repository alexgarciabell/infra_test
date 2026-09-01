terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform"
    key    = "coast/tvx-do/dataService/epsds/us-west-2/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "ci-west-epsds" {
  source                      = "../../../../../modules/dataService"
  instance_type               = "c5.xlarge"
  security_groups             = ["sg-28e5374f", "sg-6776cd02", "sg-f57d2d91"]
  aws_region                  = "us-west-2"
  single_subnet_instance_count = 3
  user_data                   = "${file("userdata_west")}"
  vpc_id                      = "vpc-ffc0399a"
  subnet_id                   = "subnet-6bb9b12d"
  comcast_application_name    = "eps"
  comcast_application_role    = "epsds"
  comcast_application_env     = "ci"
  comcast_iop_appid           = "31858"
  comcast_service_name        = "epsds"
  domain                      = "do.xcal.tv"
  key_pair                    = "coast-master-key-dev"
  data_center                 = "aw"
  role_id                     = var.role_id
  secret_id                   = var.secret_id
}

#For CI, standard DS host count is 3.
#Workspace naming format is epsds_(version)_dw_(iteration number)