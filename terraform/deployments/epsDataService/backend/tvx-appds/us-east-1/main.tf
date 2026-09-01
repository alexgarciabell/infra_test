terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform-prod"
    key    = "coast/tvx-appds/dataService/epsds/us-east-1/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "prod-east-epsds" {
  source                      = "../../../../../modules/dataService"
  instance_type               = "c5.xlarge"
  security_groups             = ["sg-39f23949", "sg-27b11253", "sg-0a55f11c4485d3535"]
  aws_region                  = "us-east-1"
  single_subnet_instance_count = 12
  user_data                   = "${file("userdata_east")}"
  vpc_id                      = "vpc-08b9236c"
  subnet_id                   = "subnet-da41b882"
  comcast_application_name    = "eps"
  comcast_application_role    = "epsds"
  comcast_application_env     = "prod"
  comcast_iop_appid           = "31858"
  comcast_service_name        = "epsds"
  name                        = "xvpsvc"
  domain                      = "appds.xcal.tv"
  key_pair                    = "coast-master-key-prod"
  data_center                 = "ae"
  role_id                     = var.role_id
  secret_id                   = var.secret_id
}

#For PROD, standard DS host count is 12.
#Workspace naming format is epsds_(version)_ae_(iteration number)