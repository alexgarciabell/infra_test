terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform-prod"
    key    = "coast/tvx-appds/dataService/cseval/us-west-2/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "prod-west-cseval" {
  source                      = "../../../../../modules/dataService"
  instance_type               = "c5.xlarge"
  security_groups             = ["sg-e5cbb89f", "sg-09c701b2539490139"]
  aws_region                  = "us-west-2"
  single_subnet_instance_count = 3
  user_data                   = "${file("userdata_west")}"
  vpc_id                      = "vpc-74695511"
  subnet_id                   = "subnet-d5286a8c"
  comcast_application_name    = "cseval"
  comcast_application_role    = "cse"
  comcast_application_env     = "prod"
  comcast_iop_appid           = "103103"
  comcast_service_name        = "cse"
  domain                      = "appds.xcal.tv"
  key_pair                    = "coast-master-key-prod"
  data_center                 = "aw"
}

#For PROD, standard DS host count is 3.
#Workspace naming format is cse_(version)_aw_(iteration number)