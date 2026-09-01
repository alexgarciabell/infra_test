terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform-prod"
    key    = "coast/tvx-appds/dataService/epsadmin/us-east-1/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "prod-east-epsadmin" {
  source                      = "../../../../../modules/dataServiceStatic"
  instance_type               = "c5.xlarge"
  security_groups             = ["sg-0423a87fd69416428","sg-39f23949", "sg-68d0ac1d", "sg-06abee1cc5ba4c799"]
  aws_region                  = "us-east-1"
  single_subnet_instance_count = 1
  user_data                   = "${file("userdata_east")}"
  vpc_id                      = "vpc-08b9236c"
  subnet_id                   = "subnet-da41b882"
  comcast_application_name    = "epsadmin"
  comcast_application_role    = "epsui"
  comcast_application_env     = "prod"
  comcast_iop_appid           = "31858"
  comcast_service_name        = "epsui"
  domain                      = "appds.xcal.tv"
  key_pair                    = "coast-master-key-prod"
  data_center                 = "ae"
  role_id                     = "${var.role_id}"
  secret_id                   = "${var.secret_id}"
}

#For PROD, standard UI host count is 1.
#Workspace naming format is epsadmin_(version)_ae_(iteration number)