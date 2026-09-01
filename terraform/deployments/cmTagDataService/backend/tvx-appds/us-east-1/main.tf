terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform-prod"
    key    = "coast/tvx-appds/dataService/cmTagDataService/us-east-1/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "prod-east-cmTagDataService" {
  source                      = "../../../../../modules/dataService"
  instance_type               = "c5.xlarge"
  security_groups             = ["sg-39f23949", "sg-4ac30f3f"]
  aws_region                  = "us-east-1"
  single_subnet_instance_count = 35
  subnet_id                   = "subnet-da41b882"
  user_data                   = "${file("userdata_east_prod")}"
  vpc_id                      = "vpc-08b9236c"
  comcast_application_name    = "taggingservice"
  comcast_application_role    = "tagds"
  comcast_application_env     = "prod"
  comcast_iop_appid           = "31928"
  comcast_service_name        = "tagds"
  domain                      = "appds.xcal.tv"
  key_pair                    = "coast-master-key-prod"
  data_center                 = "ae"
}

#For PROD, standard DS host count is 35.
#Workspace naming format is tagds_(version)_ae_(iteration number)