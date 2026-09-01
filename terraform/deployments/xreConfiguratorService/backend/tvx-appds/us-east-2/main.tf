terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform-prod"
    key    = "coast/tvx-appds/dataService/configds/us-east-2/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "prod-ohio-configds" {
  source                      = "../../../../../modules/dataService"
  instance_type               = "c5.xlarge"
  security_groups             = ["sg-6ed1db05", "sg-0498ce8b0f5cbcabc", "sg-08a1008de1fe0887f", "sg-06347f7e1a0967ace"]
  aws_region                  = "us-east-2"
  single_subnet_instance_count = 4
  user_data                   = "${file("userdata_ohio")}"
  vpc_id                      = "vpc-8918a4e1"
  subnet_id                   = "subnet-918f79eb"
  comcast_application_name    = "xreconfigurator"
  comcast_application_role    = "xcfgds"
  comcast_application_env     = "prod"
  comcast_iop_appid           = "31865"
  comcast_service_name        = "xcfgds"
  name                        = "xvpsvc"
  domain                      = "appds.xcal.tv"
  key_pair                    = "coast-master-key-prod"
  data_center                 = "ao"
}

#For PROD, standard DS host count is 4.
#Also, be sure to create 1 host separately to be used as the Ingest host.
#Workspace naming format is xreconfigds_(version)_ao_(iteration number)