terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform"
    key    = "coast/tvx-do/dataService/cmTagDataService/us-east-1/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "ci-east-cmTagDataService" {
  source                      = "../../../../../modules/dataService"
  instance_type               = "c5.xlarge"
  security_groups             = ["sg-03c283ad6d1dcd999","sg-49fcba2c", "sg-74b49806", "sg-88b78bed", "sg-a8e1eccd"]
  aws_region                  = "us-east-1"
  single_subnet_instance_count = 1
  subnet_id                   =  "subnet-e42182bd"
  user_data                   = "${file("userdata_east")}"
  vpc_id                      = "vpc-0cb21169"
  comcast_application_name    = "taggingservice"
  comcast_application_role    = "tagds"
  comcast_application_env     = "ci"
  comcast_iop_appid            = "31928"
  comcast_service_name        = "tagds"
  domain                      = "do.xcal.tv"
  key_pair                    = "coast-master-key-dev"
  data_center                 = "do"
}

#For CI, standard DS host count is 3.
#Workspace naming format is tagds_(version)_de_(iteration number)