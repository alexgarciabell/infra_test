terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform-prod"
    key    = "coast/tvx-appds/dataService/adsds/us-east-2/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "prod-ohio-adsds" {
  source                      = "../../../../../modules/dataService"
  instance_type               = "c5.xlarge"
  security_groups             = ["sg-6ed1db05", "sg-0772e42f00c7a43c0"]
  aws_region                  = "us-east-2"
  single_subnet_instance_count = 40
  user_data                   = "${file("userdata_ohio")}"
  vpc_id                      = "vpc-8918a4e1"
  subnet_id                   = "subnet-918f79eb"
  comcast_application_name    = "ads"
  comcast_application_role    = "appdiscoveryService"
  comcast_application_env     = "prod"
  comcast_iop_appid           = "31851"
  comcast_service_name        = "adsds"
  domain                      = "appds.xcal.tv"
  key_pair                    = "coast-master-key-prod"
  data_center                 = "ao"
}

#For PROD, standard DS host count is 40.
#Workspace naming format is adsds_(version)_ae_(iteration number)
#Instance Type was originally c5.2xlarge. Now converting to c5.xlarge.