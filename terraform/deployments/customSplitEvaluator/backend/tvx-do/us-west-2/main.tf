terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform"
    key    = "coast/tvx-do/dataService/cseval/us-west-2/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "ci-west-cseval" {
  source                      = "../../../../../modules/dataService"
  instance_type               = "c5.xlarge"
  security_groups             = ["sg-d8da89a5", "sg-0f9e59b5fee33bda5"]
  aws_region                  = "us-west-2"
  single_subnet_instance_count = 3
  user_data                   = "${file("userdata_west")}"
  vpc_id                      = "vpc-ffc0399a"
  subnet_id                   = "subnet-66fb3103"
  comcast_application_name    = "cseval"
  comcast_application_role    = "cse"
  comcast_application_env     = "ci"
  comcast_iop_appid           = "103103"
  comcast_service_name        = "cse"
  domain                      = "do.xcal.tv"
  key_pair                    = "coast-master-key-dev"
  data_center                 = "aw"
}

#For CI, standard DS host count is 3.
#Workspace naming format is cse_(version)_dw_(iteration number)