terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform-prod"
    key    = "coast/tvx-appds/dataService/epsds/us-west-2/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "prod-west-epsds" {
  source                      = "../../../../../modules/dataService"
  instance_type               = "c5.xlarge"
  security_groups             = ["sg-e5cbb89f", "sg-dc441da0", "sg-06df0a2d456887263"]
  aws_region                  = "us-west-2"
  single_subnet_instance_count = 12
  user_data                   = "${file("userdata_west")}"
  vpc_id                      = "vpc-74695511"
  subnet_id                   = "subnet-d5286a8c"
  comcast_application_name    = "eps"
  comcast_application_role    = "epsds"
  comcast_application_env     = "prod"
  comcast_iop_appid           = "31858"
  comcast_service_name        = "epsds"
  name                        = "xvpsvc"
  domain                      = "appds.xcal.tv"
  key_pair                    = "coast-master-key-prod"
  data_center                 = "aw"
  role_id                     = var.role_id
  secret_id                   = var.secret_id
}

#For PROD, standard DS host count is 12.
#Workspace naming format is epsds_(version)_aw_(iteration number)