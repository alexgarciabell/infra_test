terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform-prod"
    key    = "coast/tvx-appds/dataService/epsadmin/us-west-2/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "prod-west-epsadmin" {
  source                      = "../../../../../modules/dataServiceStatic"
  instance_type               = "c5.xlarge"
  security_groups             = ["sg-02939504d7112a332","sg-e5cbb89f", "sg-c84c96b4", "sg-0b75805f4c718f7d7"]
  aws_region                  = "us-west-2"
  single_subnet_instance_count = 1
  user_data                   = "${file("userdata_west")}"
  vpc_id                      = "vpc-74695511"
  subnet_id                   = "subnet-d5286a8c"
  comcast_application_name    = "epsadmin"
  comcast_application_role    = "epsui"
  comcast_application_env     = "prod"
  comcast_iop_appid           = "31858"
  comcast_service_name        = "epsui"
  domain                      = "appds.xcal.tv"
  key_pair                    = "coast-master-key-prod"
  data_center                 = "aw"
  role_id                     = "${var.role_id}"
  secret_id                   = "${var.secret_id}"
}

#For PROD, standard UI host count is 1.
#Workspace naming format is epsadmin_(version)_aw_(iteration number)