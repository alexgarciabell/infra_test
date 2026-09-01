terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform-prod"
    key    = "coast/tvx-appds/dataService/cseval/us-east-1/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "prod-east-cseval" {
  source                      = "../../../../../modules/dataService"
  instance_type               = "c5.xlarge"
  security_groups             = ["sg-39f23949", "sg-014c6d9bc574eab0c"]
  aws_region                  = "us-east-1"
  single_subnet_instance_count = 3
  user_data                   = "${file("userdata_east")}"
  vpc_id                      = "vpc-08b9236c"
  subnet_id                   = "subnet-da41b882"
  comcast_application_name    = "cseval"
  comcast_application_role    = "cse"
  comcast_application_env     = "prod"
  comcast_iop_appid           = "103103"
  comcast_service_name        = "cse"
  domain                      = "appds.xcal.tv"
  key_pair                    = "coast-master-key-prod"
  data_center                 = "ae"
}

#For PROD, standard DS host count is 3.
#Workspace naming format is cse_(version)_ae_(iteration number)