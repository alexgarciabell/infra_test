terraform {
  backend "s3" {
    bucket = "coast-infrastructure-terraform"
    key    = "coast/tvx-do/dataService/cmTagWebService/us-west-2/tfstate/terraform.tfstate"
    region = "us-west-2"
  }
}

module "ci-west-cmTagWebService" {
  source                      = "../../../../../modules/dataService"
  instance_type               = "c5.xlarge"
  security_groups             = ["sg-d8da89a5", "sg-0a685fef17aca5251","sg-02b5cb4e0ec6a02d1"]
  aws_region                  = "us-west-2"
  single_subnet_instance_count = 2
  subnet_id                   =  "subnet-66fb3103"
  user_data                   = "${file("userdata_west_ci")}"
  vpc_id                      = "vpc-ffc0399a"
  comcast_application_name    = "taggingservice"
  comcast_application_role    = "tagui"
  comcast_application_env     = "ci"
  comcast_iop_appid           = "31921"
  comcast_service_name        = "tagui"
  domain                      = "do.xcal.tv"
  key_pair                    = "coast-master-key-dev"
  data_center                 = "aw"
  role_id                     = "${var.role_id}"
  secret_id                   = "${var.secret_id}"
}

#For CI, standard UI host count is 2.
#Workspace naming format is tagportal_(version)_dw_(iteration number)
#Currently, we do not normally deploy to DO West