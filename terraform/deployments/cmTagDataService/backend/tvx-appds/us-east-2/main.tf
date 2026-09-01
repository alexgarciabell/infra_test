terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform-prod"
    key    = "coast/tvx-appds/dataService/cmTagDataService/us-east-2/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "prod-ohio-cmTagDataService" {
  source                      = "../../../../../modules/dataService"
  instance_type               = "c5.xlarge"
  security_groups             = ["sg-03b36e730e5a07e45", "sg-6ed1db05"]
  aws_region                  = "us-east-2"
  single_subnet_instance_count = 35
  subnet_id                   = "subnet-918f79eb"
  user_data                   = "${file("userdata_ohio_prod")}"
  vpc_id                      = "vpc-8918a4e1"
  comcast_application_name    = "taggingservice"
  comcast_application_role    = "tagds"
  comcast_application_env     = "prod"
  comcast_iop_appid           = "31928"
  comcast_service_name        = "tagds"
  domain                      = "appds.xcal.tv"
  key_pair                    = "coast-master-key-prod"
  data_center                 = "ao"
}

#For PROD, standard DS host count is 35.
#Workspace naming format is tagds_(version)_ao_(iteration number)