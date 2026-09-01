terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform-prod"
    key    = "coast/tvx-appds/dataService/epsds/us-east-2/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "prod-ohio-epsds" {
  source                      = "../../../../../modules/dataService"
  instance_type               = "c5.xlarge"
  security_groups             = ["sg-6ed1db05", "sg-0fc24c7b768123161", "sg-0a34b7dc001aaae06", "sg-0e6b38d48e65f08f3"]
  aws_region                  = "us-east-2"
  single_subnet_instance_count = 12
  user_data                   = "${file("userdata_ohio")}"
  vpc_id                      = "vpc-8918a4e1"
  subnet_id                   = "subnet-918f79eb"
  comcast_application_name    = "eps"
  comcast_application_role    = "epsds"
  comcast_application_env     = "prod"
  comcast_iop_appid           = "31858"
  comcast_service_name        = "epsds"
  name                        = "xvpsvc"
  domain                      = "appds.xcal.tv"
  key_pair                    = "coast-master-key-prod"
  data_center                 = "ao"
  role_id                     = var.role_id
  secret_id                   = var.secret_id
}

#For PROD, standard DS host count is 12.
#Workspace naming format is epsds_(version)_ao_(iteration number)