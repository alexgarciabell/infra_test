terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform"
    key    = "coast/tvx-do/dataService/cseval/us-east-1/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "ci-east-cseval" {
  source                      = "../../../../../modules/dataService"
  instance_type               = "c5.xlarge"
  security_groups             = ["sg-74b49806", "sg-0d5bbc905a26f1ec9"]
  aws_region                  = "us-east-1"
  single_subnet_instance_count = 3
  user_data                   = "${file("userdata_east")}"
  vpc_id                      = "vpc-0cb21169"
  subnet_id                   = "subnet-e42182bd"
  comcast_application_name    = "cseval"
  comcast_application_role    = "cse"
  comcast_application_env     = "ci"
  comcast_iop_appid           = "103103"
  comcast_service_name        = "cse"
  domain                      = "do.xcal.tv"
  key_pair                    = "coast-master-key-dev"
  data_center                 = "ae"
}

#For CI, standard DS host count is 3.
#Workspace naming format is cse_(version)_de_(iteration number)