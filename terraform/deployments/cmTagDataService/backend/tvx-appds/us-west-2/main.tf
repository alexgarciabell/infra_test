terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform-prod"
    key    = "coast/tvx-appds/dataService/cmTagDatsService/us-west-2/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "prod-west-cmTagDataService" {
  source                      = "../../../../../modules/dataService"
  instance_type               = "c5.xlarge"
  security_groups             = ["sg-e5cbb89f", "sg-0e091a73"]
  aws_region                  = "us-west-2"
  single_subnet_instance_count = 35
  subnet_id                   = "subnet-d5286a8c"
  user_data                   = "${file("userdata_west_prod")}"
  vpc_id                      = "vpc-74695511"
  comcast_application_name    = "taggingservice"
  comcast_application_role    = "tagds"
  comcast_application_env     = "prod"
  comcast_iop_appid           = "31928"
  comcast_service_name        = "tagds"
  domain                      = "appds.xcal.tv"
  key_pair                    = "coast-master-key-prod"
  data_center                 = "aw"
}

#For PROD, standard DS host count is 35.
#Workspace naming format is tagds_(version)_aw_(iteration number)