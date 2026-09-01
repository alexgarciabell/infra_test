terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform"
    key    = "coast/tvx-do/dataService/epsadmin/us-west-2/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "ci-west-epsadmin" {
  source                      = "../../../../../modules/dataServiceStatic"
  instance_type               = "c5.xlarge"
  security_groups             = ["sg-28e5374f", "sg-6776cd02", "sg-f57d2d91", "sg-d8da89a5"]
  aws_region                  = "us-west-2"
  single_subnet_instance_count = 2
  user_data                   = "${file("userdata_west")}"
  vpc_id                      = "vpc-ffc0399a"
  subnet_id                   = "subnet-6bb9b12d"
  comcast_application_name    = "epsadmin"
  comcast_application_role    = "epsui"
  comcast_application_env     = "ci"
  comcast_iop_appid           = "31858"
  comcast_service_name        = "epsui"
  domain                      = "do.xcal.tv"
  key_pair                    = "coast-master-key-dev"
  data_center                 = "aw"
  role_id                     = "${var.role_id}"
  secret_id                   = "${var.secret_id}"
 }

#For CI, standard UI host count is 2.
#Workspace naming format is epsadmin_(version)_dw_(iteration number)