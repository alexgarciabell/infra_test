terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform-prod"
    key    = "coast/tvx-appds/dataService/cseval/us-east-2/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "prod-ohio-cseval" {
  source                      = "../../../../../modules/dataService"
  instance_type               = "c5.xlarge"
  security_groups             = ["sg-6ed1db05", "sg-0accf5e37be8d2113"]
  aws_region                  = "us-east-2"
  single_subnet_instance_count = 3
  user_data                   = "${file("userdata_ohio")}"
  vpc_id                      = "vpc-8918a4e1"
  subnet_id                   = "subnet-918f79eb"
  comcast_application_name    = "cseval"
  comcast_application_role    = "cse"
  comcast_application_env     = "prod"
  comcast_iop_appid           = "103103"
  comcast_service_name        = "cse"
  domain                      = "appds.xcal.tv"
  key_pair                    = "coast-master-key-prod"
  data_center                 = "ao"
}

#For PROD, standard DS host count is 3.
#Workspace naming format is cse_(version)_ao_(iteration number)