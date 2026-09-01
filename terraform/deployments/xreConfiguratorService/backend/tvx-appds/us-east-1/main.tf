terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform-prod"
    key    = "coast/tvx-appds/dataService/configds/us-east-1/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "prod-east-configds" {
  source                      = "../../../../../modules/dataService"
  instance_type               = "c5.xlarge"
  security_groups             = ["sg-0de8f248060bd89c0", "sg-0e61a5bacc3b3417c", "sg-39f23949", "sg-0e3d0bc6b8099638a", "sg-410e7034"]
  aws_region                  = "us-east-1"
  single_subnet_instance_count = 1
  user_data                   = "${file("userdata_east")}"
  vpc_id                      = "vpc-08b9236c"
  subnet_id                   = "subnet-da41b882"
  comcast_application_name    = "xreconfigurator"
  comcast_application_role    = "xcfgds"
  comcast_application_env     = "prod"
  comcast_iop_appid           = "31865"
  comcast_service_name        = "xcfgds"
  name                        = "xvpsvc"
  domain                      = "appds.xcal.tv"
  key_pair                    = "coast-master-key-prod"
  data_center                 = "ae"
}

#For PROD, standard DS host count is 4.
#Also, be sure to create 1 host separately to be used as the Ingest host.
#Workspace naming format is xreconfigds_(version)_ae_(iteration number)