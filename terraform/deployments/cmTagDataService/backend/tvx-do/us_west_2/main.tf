terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform"
    key    = "coast/tvx-do/dataService/cmTagDataService/us-west-2/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "ci-west-cmTagDataService" {
  source                      = "../../../../../modules/dataService"
  instance_type               = "c5.xlarge"
  security_groups             = ["sg-0cb6b93c4d05f5c16","sg-28e5374f", "sg-6776cd02", "sg-d8da89a5", "sg-f57d2d91"]
  aws_region                  = "us-west-2"
  single_subnet_instance_count = 1
  subnet_id                   =  "subnet-66fb3103"
  user_data                   = "${file("userdata_west")}"
  vpc_id                      = "vpc-ffc0399a"
  comcast_application_name    = "taggingservice"
  comcast_application_role    = "tagds"
  comcast_application_env     = "ci"
  comcast_iop_appid           = "31928"
  comcast_service_name        = "tagds"
  domain                      = "do.xcal.tv"
  key_pair                    = "coast-master-key-dev"
  data_center                 = "dw"
}

#For CI, standard DS host count is 3.
#Workspace naming format is tagds_(version)_dw_(iteration number)
#Currently, we do not normally deploy to DO West