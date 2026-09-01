terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform-prod"
    key    = "coast/tvx-appds/dataService/adsadmin/us-west-2/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "prod-west-adsadmin" {
  source                      = "../../../../../modules/dataService"
  instance_type               = "c5.xlarge"
  security_groups             = ["sg-695f640d", "sg-e4dadb82", "sg-e5cbb89f", "sg-0c52413f6f931c854"]
  aws_region                  = "us-west-2"
  single_subnet_instance_count = 1
  user_data                   = "${file("userdata_west")}"
  vpc_id                      = "vpc-74695511"
  subnet_id                   = "subnet-d5286a8c"
  comcast_application_name    = "adsadmin"
  comcast_application_role    = "adsadmin"
  comcast_application_env     = "prod"
  comcast_service_name        = "adsui"
  comcast_iop_appid           = "31851"
  domain                      = "appds.xcal.tv"
  key_pair                    = "coast-master-key-prod"
  data_center                 = "aw"
}

#For PROD, standard UI host count is 1.
#Workspace naming format is adsadmin_(version)_aw_(iteration number)